{ pkgs, ... }:

{
  imports = [
    ./modules/git.nix
    ./modules/neovim
  ];

  home.username = "bliztle";
  home.homeDirectory = "/home/bliztle";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    sl
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "24.05";
}
