# Repository guide
This is the declarative nixos configuration for all my devices.
Be aware that since this configuration controls the devices agents like you are run on, making mistakes may have fatal consequences.

## Architecture
- This repository is a Nix flake.
- `flake.nix` is the entry point.
- Most changes should be made in modules rather than directly in `flake.nix`.
- 

## Layout
- `configuration/`: Root system configuration
- `home-manager`: User and program configuration
    - `dev.nix`: Developer configuration. Languages and tools are installed and configured here.
    - `nixvim/`: Neovim configuration via nixvim.
- `hosts/`: Host specific configuration
    - `framework` is this device and the primary host
    - `omen` is a dualboot desktop and rarely used

## Commands
- Validate configuration changes with `nh os build`. It builds without sudo and does not activate or switch the running system.
    - Stage newly added configuration files before building so the Git-backed flake includes them. Do not stage unrelated changes.
    - A successful build is the standard validation; separate syntax checks are normally redundant. Use targeted checks only for behavior the build cannot verify.
    - Do not run activation commands (`nix-test`, `nh os test`, or switch commands) unless explicitly requested.

## Conventions
- Always use declarative modules over imperativ approaches
    - Never perform imperative installations or setups. Always stick to configuring `home-manager/`, or `configuration/` if that is not possible.
    - Packagse are installed either through appropriate nix configuration, or via nixpkgs in `home.packages`.
- Do not edit generated files.
- Ask before adding new dependencies.
- Never use `nix-env`.
- Use `pkgs.lib` functions rather than reimplementing list/set operations.
