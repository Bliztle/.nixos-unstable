{ pkgs, ... }:

{
  imports = [
    ./modules/dev.nix
    ./modules/git.nix
    ./modules/kitty.nix
    ./modules/neovim
    ./modules/scripts
    ./modules/shell
    ./modules/sway
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
    spotify
    obsidian # No overrides needed anymore
    wdisplays
    protonmail-desktop
    discord
    wl-mirror
    libreoffice-qt
    pavucontrol
    postman
    
    # Games
    wowup-cf # Wow addon manager

    # CLI Tools
    wl-clipboard
    sl
    tldr
    unzip
    swww # Wallpaper engine
    slurp # Screenshot dependency
    grim # Screenshot dependency
    wireguard-tools
    openvpn
    easyrsa
    whois
    nmap
    # sshfs # Mount remote filesystems via ssh

    # Work
    teams-for-linux
    azure-cli

    # Fonts
    nerdfonts
    font-awesome
  ];
  programs.joplin-desktop.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "24.05";
}
