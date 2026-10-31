# Monkeytype for Nix

*A practical exploration of software packaging with Nix.*

**Project status: Completed learning project — no longer maintained.**

## Project Overview

This repository documents an investigation into packaging [Monkeytype](https://github.com/monkeytypegame/monkeytype), an open-source typing application, using Nix.

The objective was to understand how a modern TypeScript/pnpm application could be built and packaged reproducibly within the Nix ecosystem, without relying on flakes or Home Manager.

The project was undertaken as a learning exercise rather than an attempt to maintain or distribute an alternative version of Monkeytype.

All application code originates from the upstream Monkeytype contributors.

This repository contains the Nix packaging definitions, Python launcher, desktop integration files, and documentation produced during the investigation.

## Project Objectives

The exercise focused on understanding:

- Nix derivations and package definitions.
- Fetching and pinning upstream source code.
- Managing pnpm dependencies within Nix.
- Building software inside the Nix sandbox.
- Producing reproducible build outputs.
- Installing application files into the Nix store.
- Creating a launcher for the packaged application.
- Integrating an application with the Linux desktop.
- Troubleshooting build and runtime behaviour.

The emphasis throughout was on understanding the packaging process and documenting the reasoning behind implementation decisions.

## Implementation

The project uses a conventional Nix packaging structure.

### Nix Packaging

`package.nix` defines the package and its build process.

`default.nix` provides the entry point for building the package using `nix-build`.

The packaging process:

- Fetches the upstream Monkeytype source.
- Retrieves pnpm dependencies through Nix.
- Builds the application within the Nix sandbox.
- Produces the application's static website.
- Installs the resulting files into the package output.

The upstream source is pinned to a specific revision to support reproducible builds.

### Python Launcher

`monkeytype-launcher.py` provides the runtime launcher.

Its responsibilities include:

- Serving the packaged application locally.
- Opening the application in the default browser.
- Detecting port conflicts.
- Providing runtime diagnostics.
- Handling shutdown without leaving background processes.

Keeping the launcher separate from the Nix packaging allowed the build process and runtime behaviour to be developed and understood independently.

### Desktop Integration

The repository includes `monkeytype.desktop` as part of the desktop integration work.

The project explored how a locally packaged web application could be presented as a desktop application.

A dedicated Electron, Tauri, or WebKit wrapper was not implemented.

## Building

From the project directory:

```bash
nix-build
```

This produces a `result` symlink pointing to the package in the Nix store.

## Running

Launch the packaged application with:

```bash
./result/bin/monkeytype
```

The Python launcher serves the packaged website locally and opens it in the default browser.

The application uses:

```text
127.0.0.1:8765
```

If an existing browser cache retains assets from an earlier build, clearing the site's browser data may resolve display problems.

## Project Documentation

`Monkeytype.org` contains the development notes and technical investigation.

It records the packaging process, implementation decisions, problems encountered, and lessons learned.

The documentation is retained as part of the project's educational value.

## Limitations

The packaging exercise successfully produced a working application.

However, the project encountered stability and compatibility issues associated with the upstream application.

These issues complicated continued maintenance and reduced the practical value of maintaining a separate package.

Additional limitations include:

- Authentication was not implemented.
- No dedicated desktop application wrapper was developed.
- The package was not submitted to Nixpkgs.
- Ongoing compatibility with newer upstream releases is not maintained.

This repository should not be considered a supported or current Monkeytype distribution.

## Project Outcome

**The project achieved its primary objective: developing a practical understanding of Nix software packaging.**

The exercise demonstrated how an existing application could be fetched, built, packaged, installed, and launched using Nix.

It also provided experience working with build dependencies, reproducibility, runtime integration, and troubleshooting.

Although the resulting package worked, maintaining compatibility with the upstream application was outside the project's intended scope.

The purpose was not to become a Monkeytype package maintainer, but to understand the mechanisms involved in packaging software for NixOS.

By that measure, the project was successful.

## Project Conclusion

Development has concluded.

Monkeytype for Nix remains available as a documented learning project demonstrating the packaging of a modern web application within the Nix ecosystem.

The repository preserves the implementation and development notes as a record of the investigation.

No further development or maintenance is planned.

## Attribution

Monkeytype is developed and maintained by its upstream contributors.

This repository is an independent packaging experiment and is not affiliated with or endorsed by the Monkeytype project.

The original application remains the work of its respective contributors.

---

*Oggie*
