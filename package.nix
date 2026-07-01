{
  lib,
  stdenv,
  fetchFromGitHub,
  nodejs,
  pnpm_10,
  pnpmConfigHook,
  fetchPnpmDeps,
}:

stdenv.mkDerivation rec {
  pname = "monkeytype";
  version = "unstable-2026-06-30";

  src = fetchFromGitHub {
    owner = "monkeytypegame";
    repo = "monkeytype";
    rev = "master";
    hash = "sha256-a9nvQGs+CvPaU1mXADUkbdNRI1c0y2BEcn/4HpakEEQ=";
  };

  pnpmInstallFlags = [ "--no-frozen-lockfile" ];

  pnpmDeps = fetchPnpmDeps {
    inherit pname version src pnpmInstallFlags;
    pnpm = pnpm_10;
    fetcherVersion = 3;
    hash = "sha256-PNZ42D89XE56q4tK5PwraZAqvomw7RKVN8wDak4Zxm0=";
  };

  nativeBuildInputs = [
    nodejs
    pnpm_10
    pnpmConfigHook
  ];

  RECAPTCHA_SITE_KEY = "dummy";

  postPatch = ''
    cp frontend/src/ts/constants/firebase-config-example.ts \
    frontend/src/ts/constants/firebase-config-live.ts
  '';

  buildPhase = ''
    runHook preBuild
    pnpm build
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/monkeytype
    cp -r frontend/dist/* $out/share/monkeytype/
    runHook postInstall
  '';
}
