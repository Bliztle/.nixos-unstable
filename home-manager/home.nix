{
  pkgs,
  config,
  conf,
  lib,
  ...
}:
{
  imports = [
    ./dev.nix
    ./git.nix
    ./nixvim
    ./scripts
    ./shell
    ./ssh.nix
    ./sway
    ./uni.nix
    ./waybar
    ./wofi
    ./syncthing.nix
  ]
  ++ lib.optionals conf.custom.hyprland.enable [ ./hyprland ];

  home.username = "bliztle";
  home.homeDirectory = "/home/bliztle";

  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Applications
    # chatgpt # Still points to macos (nix darwin) version
    discord
    firefox
    herdr
    jellyfin-media-player
    libreoffice-qt # Temporarily removed as it could not build
    obsidian # No overrides needed anymore
    pavucontrol
    protonmail-desktop
    proton-vpn
    qbittorrent
    speedcrunch
    spotify
    vlc
    wdisplays
    wl-mirror
    zathura
    zotero # Zotero plugins are unfortunately handled imperatively in zotero
    signal-desktop
    prismlauncher # Minecraft Launcher
    bitwarden-desktop
    kdePackages.dolphin # File manager
    cutter # Hydra but i like it more

    # Games
    # wowup-cf # Wow addon manager

    # protonmail-bridge
    # protonmail-bridge-gui
    # gcr

    # CLI Tools
    wget
    devenv
    dig
    grim # Screenshot dependency
    sway-contrib.grimshot
    hyprlock
    inetutils # ftp and more
    kubectl
    kubelogin
    libnotify # notify-send for desktop notifications
    jq
    nmap
    playerctl
    poppler-utils # pdf tools
    quickemu # QEMU wrapper
    ripgrep
    bat
    fd
    eza
    rofi
    sl
    slurp # Screenshot dependency
    sops
    swaycwd
    tldr
    traceroute
    unzip
    usbutils # usb device management, lsusb
    wf-recorder # Wayland screen recording dependency
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
  # services.gnome-keyring.enable = true;
  # services.protonmail-bridge = {
  #   enable = true;
  # };
  programs.thunderbird = {
    enable = true;
    profiles = { }; # This is required to build
  };
  programs.btop.enable = true;
  services.dunst = {
    enable = true;
    settings = {
      global = {
        origin = "top-right";
        offset = "(12, 48)";
        width = "(320, 420)";
        height = "(0, 300)";
        notification_limit = 5;
        gap_size = 8;
        corner_radius = 8;
        frame_width = 2;
        frame_color = "#c678dd";
        separator_color = "frame";
        font = "JetBrainsMono Nerd Font 10";
        padding = 12;
        horizontal_padding = 12;
        text_icon_padding = 10;
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 48;
        progress_bar = true;
        progress_bar_height = 8;
        progress_bar_frame_width = 0;
        progress_bar_corner_radius = 4;
        highlight = "#61afef";
      };

      urgency_low = {
        background = "#282c34f2";
        foreground = "#7a818e";
        timeout = 4;
      };

      urgency_normal = {
        background = "#282c34f2";
        foreground = "#abb2bf";
        timeout = 6;
      };

      urgency_critical = {
        background = "#282c34f2";
        foreground = "#e06c75";
        frame_color = "#e06c75";
        timeout = 0;
      };
    };
  };
  services.awww.enable = true;
  services.udiskie.enable = true;
  programs.kitty.enable = true;
  programs.joplin-desktop.enable = true;
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
  };

  programs.nh = {
    enable = true;
    flake = /home/bliztle/.nixos-unstable;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-daily 7 --keep-weekly 2";
    };
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
  home.file = builtins.listToAttrs (
    map (name: {
      name = ".config/${name}";
      value = {
        source = ./config + "/${name}";
        recursive = true;
        force = true;
      };
    }) (builtins.attrNames (builtins.readDir ./config))
  );

  home.stateVersion = "26.05";
}
