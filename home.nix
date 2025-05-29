{pkgs, ...}: {
  imports = [
    ./modules/dev.nix
    ./modules/git.nix
    ./modules/hypr/home.nix
    ./modules/nvf
    ./modules/scripts
    ./modules/shell
    ./modules/ssh.nix
    ./modules/sway
    ./modules/waybar
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
    speedcrunch

    # Games
    # wowup-cf # Wow addon manager

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
    expressvpn
    whois
    nmap
    # sshfs # Mount remote filesystems via ssh
    traceroute
    dig
    sops
    kubectl
    playerctl
    hyprlock
    rofi
    sway-contrib.grimshot

    # Work
    teams-for-linux
    azure-cli

    # Fonts
    # nerdfonts
    font-awesome
  ];
  programs.kitty.enable = true;
  services.dunst.enable = true;
  programs.joplin-desktop.enable = true;
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "application/pdf" = "firefox.desktop";
      "x-scheme-handler/msteams" = "teams-for-linux.desktop";
    };
  };

  # add ./modules/config/* to ~/.config
  home.file = builtins.listToAttrs (map (name: {
    name = ".config/${name}";
    value = {
      source = ./modules/config + "/${name}";
      recursive = true;
      force = true;
    };
  }) (builtins.attrNames (builtins.readDir ./modules/config)));

  home.stateVersion = "24.05";
}
