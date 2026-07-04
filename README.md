# Monkeytype for Nix

This repository packages the
[Monkeytype](https://github.com/monkeytypegame/monkeytype)
typing application for Nix while documenting the packaging process.

All application code originates from the Monkeytype contributors.
This repository contains the Nix packaging, launcher, documentation,
and project notes.

## About Monkeytype

Monkeytype is an active open source project developed by its contributors.

This repository does **not** modify Monkeytype itself.
Instead, it focuses on packaging the existing project for Nix in a
reproducible and well-documented manner.

## Current Status

The package currently:

- Fetches the upstream source from GitHub.
- Fetches pnpm dependencies using Nix.
- Builds reproducibly inside the Nix sandbox.
- Produces the Monkeytype static site.
- Installs a `monkeytype` launcher.
- Automatically opens the default browser.
- Serves the packaged site locally.
- Detects port conflicts before launching.
- Shuts down cleanly without leaving background processes.

Current limitations:

- No desktop launcher (`.desktop` file) is provided yet.
- No dedicated desktop wrapper (Electron/Tauri/WebKit) exists.
- Authentication is not currently supported.
- The package has not been submitted to Nixpkgs.

## Current Goals

The current focus is desktop integration:

- Add a `.desktop` launcher.
- Install application icons.
- Integrate with the freedesktop desktop environment.
- Continue documenting packaging decisions.

## Building

```bash
nix-build

Milestones

Completed:

Reproducible build from upstream source.
Source pinned to a specific upstream commit.
Documented derivation.
Install verification.
Dedicated Python launcher.
Automatic browser launch.
Friendly runtime diagnostics.
Runnable monkeytype command.
Why this repository?

This project began as a learning exercise to understand how a modern
TypeScript/pnpm application can be packaged reproducibly using Nix,
without relying on flakes or Home Manager.

Over time it evolved into a documented exploration of software packaging.
The aim is not simply to produce a working package, but to understand
why packaging decisions are made and to record that reasoning.

package.nix documents the packaging.
Project.org records the engineering decisions.
The launcher remains a separate component so that packaging and runtime
behaviour each have a single responsibility.

This repository is therefore as much about understanding Nix packaging
as it is about packaging Monkeytype.

If you decide to use it, you're doing so with the understanding that it
is an evolving packaging project rather than an official Monkeytype release.

— Oggie
