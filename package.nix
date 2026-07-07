# Oggie says: This package is intentionally commented.
#
# The comments explain why particular decisions were made,
# not just what the code does.
#
# Some workarounds are temporary and marked with TODOs.

{
  # General helper library used throughout Nixpkgs.
  # Provides functions, licenses, fakeHash, platforms, etc.
  lib,

  # Standard build environment.
  # Provides mkDerivation, the foundation of most Nix packages.
  stdenv,

  # Fetches the upstream source from GitHub reproducibly.
  fetchFromGitHub,

  # Node.js runtime needed to build Monkeytype.
  nodejs,

  # The pnpm package manager (version 10).
  # Used during dependency resolution and build.
  pnpm_10,

  # Hook that prepares the pnpm build environment.
  pnpmConfigHook,

  # Helper that fetches and vendors pnpm dependencies
  # before the sandboxed build begins.
  fetchPnpmDeps,
  python3,
}:

stdenv.mkDerivation rec {
  pname = "monkeytype";

  # This is not a released version yet.
  # It identifies an unstable build from the upstream master branch.
  version = "unstable-2026-06-30";

  launcher = ./monkeytype-launcher.py;
  desktopFile = ./monkeytype.desktop;

  # Fetch the upstream Monkeytype source.
  # TODO: replace `master` with a pinned commit or release tag.
  src = fetchFromGitHub {
    owner = "monkeytypegame";
    repo = "monkeytype";
    rev = "4b92621a5ce4488a0efcef5f6676b90afd6e648e";
    hash = "sha256-a9nvQGs+CvPaU1mXADUkbdNRI1c0y2BEcn/4HpakEEQ=";
  };

  # Upstream currently fails a frozen pnpm install because the lockfile
  # and pnpm workspace configuration do not fully agree.
  #
  # TODO: investigate whether this can be removed by pinning a release,
  # regenerating the lockfile, or patching the upstream configuration.
  pnpmInstallFlags = [ "--no-frozen-lockfile" ];

  # Fetch pnpm dependencies ahead of the sandboxed build.
  # This avoids network access during `buildPhase`.
  pnpmDeps = fetchPnpmDeps {
    inherit pname version src pnpmInstallFlags;
    pnpm = pnpm_10;
    fetcherVersion = 3;
    hash = "sha256-PNZ42D89XE56q4tK5PwraZAqvomw7RKVN8wDak4Zxm0=";
  };

  # Tools needed at build time.
  nativeBuildInputs = [
    nodejs
    pnpm_10
    pnpmConfigHook
    python3
  ];

  # Tools needed at runtime.
  buildInputs = [
    python3
];

  # Monkeytype's production Vite config requires this variable.
  # For this local/static build, a dummy value is enough to complete the build.
  #
  # TODO: confirm whether this has runtime consequences.
  RECAPTCHA_SITE_KEY = "dummy";

  # Upstream expects a live Firebase config file during production builds,
  # but the public repository only includes an example config.
  #
  # For this experimental package, use the example config as the live config.
  #
  # TODO: understand whether this is correct for offline/local use.
  postPatch = ''
    cp frontend/src/ts/constants/firebase-config-example.ts \
       frontend/src/ts/constants/firebase-config-live.ts
  '';

  # Build the Monkeytype workspace.
  buildPhase = ''
    runHook preBuild
    pnpm build
    runHook postBuild
  '';

  # Install the generated frontend static site.
  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/monkeytype
    cp -r frontend/dist/* $out/share/monkeytype/

    # Install the application icon into the freedesktop icon hierarchy.
    install -Dm644 \
      $out/share/monkeytype/images/icons/general_icon_x512.png \
      $out/share/icons/hicolor/512x512/apps/monkeytype.png

    # Install the desktop entry.

    install -Dm644 ${desktopFile} $out/share/applications/monkeytype.desktop

    # Install the launcher.
    install -Dm755 ${launcher} $out/bin/monkeytype

    substituteInPlace $out/bin/monkeytype \
      --replace-fail "@python@" "${python3}/bin/python3" \
      --replace-fail "@site@" "$out/share/monkeytype"

    runHook postInstall
  '';

  doInstallCheck = true;

  installCheckPhase = ''
    runHook preInstallCheck
    test -f $out/share/monkeytype/index.html
    runHook postInstallCheck
  '';

  meta = {
    description = "Minimalistic and customizable typing test web application";
    homepage = "https://github.com/monkeytypegame/monkeytype";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
}
