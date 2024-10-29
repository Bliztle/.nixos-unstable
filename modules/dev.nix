{ lib, pkgs, ... }:

{
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    programs.vscode.enable = true;

    home.packages = with pkgs; [
      # C
      gcc
      # C#
      dotnet-sdk_8
      # Javascript / Typescript
      nodePackages_latest.pnpm
      # Python
      python3
      uv
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
