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
    ./modules/uni.nix
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
    dig
    expressvpn
    grim # Screenshot dependency
    sway-contrib.grimshot
    hyprlock
    inetutils # ftp and more
    kubectl
    nmap
    openvpn
    playerctl
    poppler-utils # pdf tools
    ripgrep
    rofi
    sl
    slurp # Screenshot dependency
    sops
    # sshfs # Mount remote filesystems via ssh
    swww # Wallpaper engine
    tldr
    traceroute
    unzip
    usbutils # usb device management, lsusb
    whois
    wireguard-tools
    wl-clipboard

    # Work
    teams-for-linux
    azure-cli

    # Fonts
    # nerdfonts
    font-awesome
  ];
  programs.btop.enable = true;
  services.dunst.enable = true;
  programs.kitty.enable = true;
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
