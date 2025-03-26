{ pkgs, ... }:

{
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    programs.vscode.enable = true;

    home.packages = with pkgs; [
      jetbrains.pycharm-professional

      # C
      gcc
      libclang
      # C#
      dotnet-sdk_8
      # Haskell
      # (haskellPackages.ghcWithPackages (pkgs: with pkgs; [ 
      #   stack 
      #   cabal-install
      # ]))

      # Javascript / Typescript
      nodePackages_latest.pnpm
      # OCaml - `ocaml` and `merlin` are installed and managed by opam
      # ocaml
      # dune_3
      # opam
      # ocamlPackages.merlin
      # ocamlPackages.utop
      # ocamlPackages.odoc
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
