{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
{
  ##### Display configuration #####
  # Enable Display Manager
  services = {
    displayManager = {
      logToFile = true; # ~/xsession-errors
      sddm = lib.mkDefault {
        enable = true;
        wayland = {
          enable = true;
          compositor = "kwin";
        };
        package = pkgs.kdePackages.sddm;
        settings.Theme = {
          CursorTheme = "breeze_cursors";
          CursorSize = 24;
        };
      };
    };
  };

  # Plasma used to provide SDDM's cursor theme implicitly.
  environment.systemPackages = [ pkgs.kdePackages.breeze ];
  # xdg.icons.fallbackCursorThemes = [ "breeze_cursors" ];

  # Enable window managers and desktop environments to register with display manager
  programs.sway.enable = true;
  programs.hyprland = lib.mkIf config.custom.hyprland.enable {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
    xwayland.enable = true;
  };
  # services.desktopManager.plasma6.enable = true;
  # services.xserver.enable = true;

  ##### NVidia support #####
  hardware.nvidia = lib.mkIf config.custom.nvidia.enable {
    # enable = true;
    open = false; # use closed source
    modesetting.enable = true; # something something better with wayland
    nvidiaSettings = true; # config menu `nvidia-settings`
  };
  services.xserver.videoDrivers = lib.mkIf config.custom.nvidia.enable [ "nvidia" ];
  # Enable Sway with unsupported GPU
  services.displayManager.sessionPackages =
    let
      swayUnsupportedDesktopItem = pkgs.makeDesktopItem {
        name = "sway-unsupported";
        desktopName = "Sway (Unsupported GPU)";
        comment = "Start Sway with --unsupported-gpu";
        exec = "${pkgs.swayfx}/bin/sway --unsupported-gpu";
        type = "Application";
        destination = "/share/wayland-sessions";
      };

      swayUnsupportedSession = swayUnsupportedDesktopItem.overrideAttrs (old: {
        passthru.providedSessions = [ "sway-unsupported" ];
      });
    in
    [ swayUnsupportedSession ];
}
