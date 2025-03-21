{ pkgs, lib, ... }:

{
  imports = [
    ./modules/dev.nix
    ./modules/git.nix
    ./modules/kitty.nix
    ./modules/neovim
    ./modules/scripts
    ./modules/shell
    ./modules/ssh.nix
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
    qbittorrent
    vlc
    rnote
    jellyfin-media-player
    
    # Games
    wowup-cf # Wow addon manager

    # CLI Tools
    inetutils # ftp and more
    ripgrep
    wl-clipboard
    sl
    tldr
    unzip
    swww # Wallpaper engine
    slurp # Screenshot dependency
    grim # Screenshot dependency
    wireguard-tools
    openvpn
    # expressvpn
    whois
    nmap
    # sshfs # Mount remote filesystems via ssh
    traceroute
    dig
    sops
    kubectl

    # Work
    teams-for-linux
    azure-cli

    # Fonts
    # nerdfonts
    font-awesome
  ];
  services.dunst.enable = true;
  programs.joplin-desktop.enable = true;
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "24.05";
}
