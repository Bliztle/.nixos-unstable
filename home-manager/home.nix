{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./dev.nix
    ./git.nix
    ./nvf
    ./nixvim
    ./scripts
    ./shell
    ./ssh.nix
    ./sway
    ./uni.nix
    ./waybar
    ./wofi
    ./zsh.nix
    ./syncthing.nix
  ];

  home.username = "bliztle";
  home.homeDirectory = "/home/bliztle";

  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Applications
    discord
    firefox
    # jellyfin-media-player # Temporarily removed, as it depends on qtwebengine 5, which is unmaintained and has security issues
    libreoffice-qt
    obsidian # No overrides needed anymore
    pavucontrol
    postman
    protonmail-desktop
    protonvpn-gui
    qbittorrent
    rnote
    speedcrunch
    spotify
    vlc
    wdisplays
    wl-mirror
    zathura
    zotero
    signal-desktop

    # Games
    # wowup-cf # Wow addon manager

    # CLI Tools
    dig
    grim # Screenshot dependency
    sway-contrib.grimshot
    hyprlock
    inetutils # ftp and more
    kubectl
    kubelogin
    fluxcd
    jq
    nmap
    playerctl
    poppler-utils # pdf tools
    quickemu
    ripgrep
    rofi
    sl
    slurp # Screenshot dependency
    sops
    swaycwd
    # sshfs # Mount remote filesystems via ssh
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
  services.swww.enable = true;
  services.udiskie.enable = true;
  programs.kitty.enable = true;
  programs.joplin-desktop.enable = true;
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.nh = {
    enable = true;
    flake = /home/bliztle/.nixos-unstable;
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

  home.file =
    # add ./modules/config/* to ~/.config
    builtins.listToAttrs (
      map (name: {
        name = ".config/${name}";
        value = {
          source = ./config + "/${name}";
          recursive = true;
          force = true;
        };
      }) (builtins.attrNames (builtins.readDir ./config))
    )
    // {
      mnt.source = config.lib.file.mkOutOfStoreSymlink "/run/media/bliztle";
    };

  home.stateVersion = "24.05";
}
