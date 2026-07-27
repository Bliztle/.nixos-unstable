# Repository guide
This is the declarative nixos configuration for all my devices.

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
- Build: `nix-test` - This is a custom alias, adding files to git before testing the configuration
    - Do not test configurations unless explicitly asked to do so. Leave that to me.

## Conventions
- Always use declarative modules over imperativ approaches
    - Never perform imperative installations or setups. Always stick to configuring `home-manager/`, or `configuration/` if that is not possible.
    - Packagse are installed either through appropriate nix configuration, or via nixpkgs in `home.packages`.
- Do not edit generated files.
- Ask before adding new dependencies.
- Never use `nix-env`.
- Use `pkgs.lib` functions rather than reimplementing list/set operations.
