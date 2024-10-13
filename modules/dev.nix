{ lib, pkgs, ... }:

{
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    programs.vscode.enable = true;

    home.packages = with pkgs; [
      # Nix
      nil
      # Lua
      lua-language-server
      # C
      gcc
      # C#
      dotnet-sdk_8
      omnisharp-roslyn
      # Javascript / Typescript
      # nodePackages_latest.nodejs # Requirement for pnpm commands to work properly
      nodePackages_latest.pnpm
      nodePackages_latest.typescript-language-server
      # Python
      pyright
      # Rust
      rustc
      cargo
      rustfmt
      clippy
      evcxr # REPL and Jupyter kernel
      rust-analyzer
    ];

    # Add node as alias to avoid adding npm to the path
    programs.zsh.shellAliases.node = "${pkgs.nodejs}/bin/node";
}
