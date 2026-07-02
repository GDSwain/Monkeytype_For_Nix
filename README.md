# Monkeytype for Nix

This repository explores packaging the
[Monkeytype](https://github.com/monkeytypegame/monkeytype)
typing application for Nix.

The project started as a learning exercise to understand how a modern
TypeScript/pnpm application can be packaged reproducibly using Nix,
without relying on flakes or Home Manager.

## Current Status

The package currently:

- Fetches the upstream source from GitHub.
- Fetches pnpm dependencies using Nix.
- Builds successfully in the Nix sandbox.
- Produces the static Monkeytype website under:

```text
result/share/monkeytype
```

## Current Limitations

This is still an experimental package.

It currently does **not** provide:

- a `monkeytype` launcher
- desktop integration
- an Electron/Tauri wrapper
- installation into Nixpkgs

## Goals

Near-term goals include:

- cleaning up the derivation
- documenting packaging decisions
- understanding upstream build assumptions
- exploring desktop integration

## Building

```bash
nix-build
```

## Why this repository?

The purpose of this repository is not only to package Monkeytype,
but also to document the reasoning behind the packaging process.
Many of the comments in `package.nix` explain *why* a particular
decision was made, rather than simply *what* the code does.

This repository is as much about learning Nix packaging as it is about packaging Monkeytype.

It is currently an exploration rather than a finished package. It builds, but it is not yet intended for general use and may never reach that stage.

If you're curious, have a look around. If you decide to use it, you're doing so because you understand what it is.

— Oggie
