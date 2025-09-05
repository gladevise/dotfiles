# AGENTS Guide

Audience: AI coding agents and human contributors working on this dotfiles repo. Keep changes small, safe, and idempotent. When in doubt, ask before running anything that installs or upgrades software on a user machine.

## Overview

- Purpose: Provision a fresh Ubuntu/GNOME environment and manage personal dotfiles via symlinks.
- Entry point: `install.sh` orchestrates installers for APT, pip/pipx, snap, cargo, Node.js (via nvm), Flatpak, Neovim, dotfile linking, and GNOME settings.
- Non‑goals: This repo is not a generic package manager; keep scope to personal setup.

## Repository Layout

- `scripts/`: Install/upgrade utilities. Each file is focused and re‑runnable.
- `settings/`: Source of truth for dotfiles, mirroring `$HOME` layout (e.g. `settings/.config/...`).
- `README.md`: Basic usage.
- `biome.jsonc`: JSON/JS tooling preferences for projects that support Biome; not required for shell scripts.

## Safety & Execution Rules

- Don’t run installers/upgraders without explicit user approval. Many scripts call `sudo`, install system packages, or modify global config.
- Prefer reading and modifying files over executing them. If execution is required, design for dry runs or call out prompts clearly.
- Maintain idempotency: scripts should be safe to re‑run and converge without harmful side effects.
- Respect user state: do not check in secrets; do not hard‑code user/profile specifics beyond what’s already here.

## Install Flow (reference)

`install.sh` runs, in order:

1) `install_apt.sh`
2) `install_pip.sh`
3) `install_snap.sh`
4) `install_cargo.sh` (also installs Alacritty + Starship)
5) `install_node.sh` then `install_npm.sh`
6) `install_appimages.sh` (currently commented examples)
7) `install_flatpak.sh` (delegates to `install_flathub_apps.sh`)
8) `install_nvim.sh`
9) `link.sh` (symlink dotfiles)
10) `gsettings.sh`

Keep this sequence coherent when adding or modifying installers.

## Adding or Updating Packages

- APT: Edit `scripts/install_apt.sh` and add package names to the `packages` array. Upgrades are handled by `scripts/upgrade_apt.sh` (no per‑package list needed).
- pip/pipx: Add CLI tools to `scripts/install_pip.sh` `packages` array.
  - The script auto‑detects Ubuntu version; on > 24 it uses `pipx`, else user‑level `pip3`. Preserve this behavior for new tools.
- cargo: Add crates to `scripts/install_cargo.sh` `packages` array. Ensure necessary build deps remain installed (`libssl-dev`, `pkg-config`). Alacritty/Starship installers are invoked from here; keep them working.
- Node.js: Global npm packages belong in `scripts/install_npm.sh` under `packages`. Always ensure `nvm use --lts` before global installs.
- Flatpak: Add app IDs to `scripts/install_flathub_apps.sh`.
- Snap: Add packages to `scripts/install_snap.sh`.
- VS Code extensions: Update `scripts/vscode_extensions_list.txt`; install via `scripts/install_vscode_extensions.sh` and upgrade via `scripts/upgrade_vscode_extensions.sh`.

## Dotfiles Management

- Source files live under `settings/` mirroring `$HOME` paths (e.g. `settings/.bash_aliases`, `settings/.config/git/config`).
- `scripts/link.sh` creates missing directories and symlinks all files under `settings/` into `$HOME` using relative structure.
- To add a new dotfile, place it under `settings/` in the corresponding path and rely on `link.sh` to deploy it. Avoid secrets or machine‑local data.

## GNOME/Desktop Settings

- Put additional tweaks in `scripts/gsettings.sh`. Keep commands idempotent and safe if run multiple times.

## Conventions for Shell Scripts

- Keep scripts POSIX/Bash‑compatible as currently written; follow existing style (arrays, `pushd/popd`, echoing `$PWD`).
- Design for idempotency and fail‑fast behavior where appropriate. If introducing stricter modes (e.g. `set -euo pipefail`), do so only when fully validated across all called commands.
- Prefer small focused functions; reuse helpers from `scripts/utils.sh` where available.
- If adding network fetches, pin versions or use stable channels where possible. Use helper `get_github_latest_release_tag` thoughtfully.
- Support non‑interactive runs: avoid prompts or pass `-y` when safe.

## Testing & Validation (without changing the system)

- Static checks: run `shellcheck` locally when possible; keep scripts syntax‑clean.
- Dry‑run patterns:
  - For loops/queries, print actions with `echo` first when changing logic.
  - Consider guarding destructive/system‑wide changes behind an opt‑in env var (e.g. `DRY_RUN=1`) if you add new behaviors.
- Symlink pass: run `scripts/link.sh` alone to verify path resolution and symlink outputs (safe by default).
- For upgrade logic, validate parsing pipelines (e.g., `upgrade_pip.sh`, `upgrade_npm.sh`) by echoing intermediate results before executing package managers.

## Common Tasks

- Add a new CLI tool (pip): append to `packages` in `install_pip.sh` and let the version‑based pip/pipx logic apply.
- Add a new cargo tool: append to `packages` in `install_cargo.sh`; ensure it compiles with existing build deps.
- Add a VS Code extension: add to `scripts/vscode_extensions_list.txt` (one per line).
- Add a Flatpak/Snap app: update the respective installer file.
- Add a new dotfile: place it in `settings/` mirroring `$HOME` and run `scripts/link.sh`.

## Do Not

- Do not execute installers/upgraders automatically in CI or on shared environments.
- Do not remove idempotency checks or add interactivity that blocks unattended runs.
- Do not commit machine‑specific credentials or tokens.

## Notes for AI Agents (Codex CLI)

- Planning: Use a short, focused plan for multi‑step edits; keep exactly one step in progress.
- File edits: Use `apply_patch` to modify files; keep diffs minimal and scoped.
- Repo analysis: Prefer `rg` for fast searches; read files in small chunks.
- Safety: Avoid running `sudo` or networked commands unless the user explicitly asks and approves.
- Validation: Where feasible, prefer static analysis and dry‑run outputs over executing installers.

This guide aims to make changes predictable, reversible, and safe while keeping the setup reliable for the repository owner.
