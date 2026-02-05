{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
  };

  programs.vscode.enable = true;

  home.packages = with pkgs; [
    android-studio
    android-tools

    # C
    gcc
    libclang
    # C#
    dotnet-sdk_8
    # Haskell
    (haskellPackages.ghcWithPackages (
      pkgs: with pkgs; [
        stack
        cabal-install
      ]
    ))
    # Java
    jdk17
    glib
    gtk4
    gtk3-x11
    # Javascript / Typescript
    nodePackages_latest.npm
    nodePackages_latest.pnpm
    # OCaml - `ocaml` and `merlin` are installed and managed by opam
    # ocaml
    # dune_3
    # opam
    # ocamlPackages.merlin
    # ocamlPackages.utop
    # ocamlPackages.odoc
    # Prolog
    swi-prolog
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
    # Swift
    # swift
    usbmuxd
    # Typst
    typst
  ];

  programs.bacon.enable = true;
}
