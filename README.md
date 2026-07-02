# Monkeytype for Nix

This repository explores packaging the
[Monkeytype](https://github.com/monkeytypegame/monkeytype)
typing application for Nix. All application code originates from the Monkeytype contributors.
This repository contains the Nix packaging, documentation, and project notes.

## About Monkeytype

Monkeytype itself is an active open source project developed by its contributors.
This repository does **not** modify Monkeytype's functionality.
Its purpose is to package the existing project for Nix while documenting the packaging process.

## Current Status

The package currently:

- Fetches the upstream source from GitHub.
- Fetches pnpm dependencies using Nix.
- Builds successfully in the Nix sandbox.
- Produces the Monkeytype static site.
- Installs a `monkeytype` launcher.
- Serves the packaged site locally via a small HTTP server.

Current limitations:

- The browser is currently opened manually after starting the local server.
- No desktop launcher (.desktop file) is provided.
- No dedicated desktop wrapper (Electron/Tauri/WebKit) exists.
- The package has not been submitted to Nixpkgs

## Current Goals

- cleaning up the derivation
- documenting packaging decisions
- understanding upstream build assumptions
- exploring desktop integration

## Building

```bash
nix-build
```
## Milestones

The project has currently reached the following milestones:

- Reproducible build from upstream source
- Source pinned to a specific upstream commit
- Documented derivation
- Install verification
- Runnable `monkeytype` command

## Why this repository?

The project started as a learning exercise to understand how a modern
TypeScript/pnpm application can be packaged reproducibly using Nix,
without relying on flakes or Home Manager.

The purpose of this repository is not only to package Monkeytype,
but also to document the reasoning behind the packaging process.
Many of the comments in `package.nix` explain *why* a particular
decision was made, rather than simply *what* the code does.

This repository is as much about understanding Nix packaging as it is about packaging Monkeytype.

It is currently an exploration rather than a finished package.
While it is now usable, the primary goal of this repository is
to understand and document the process of packaging a modern
web application for Nix.

If you're curious, have a look around. If you decide to use it, you're doing so because you understand what it is.

— Oggie
