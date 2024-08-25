{ pkgs, ... }:

{
  imports = [
    ./modules/git.nix
    ./modules/kitty.nix
    ./modules/neovim
    ./modules/scripts
    ./modules/shell
    ./modules/sway.nix
    ./modules/wallpaper
    ./modules/zsh.nix
  ];

  home.username = "bliztle";
  home.homeDirectory = "/home/bliztle";

  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Applications
    firefox
    nerdfonts
    spotify
    obsidian # No overrides needed anymore
    wdisplays
    protonmail-desktop

    # CLI Tools
    wl-clipboard
    sl
    tldr
    unzip
    swww # Wallpaper engine
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "24.05";
}
