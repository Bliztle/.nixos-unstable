{
  pkgs,
  config,
  conf,
  lib,
  ...
}:
{
  imports =
    [
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
    # chatgpt
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
    wf-recorder # Sway screen recording dependency
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
  services.dunst.enable = true;
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
