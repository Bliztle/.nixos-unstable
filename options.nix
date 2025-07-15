{lib, ...}: {
  options.custom = {
    desktop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Is this a desktop system? If so, we need to disable some features.";
    };
    hostname = lib.mkOption {
      type = lib.types.str;
      description = "The hostname for the system.";
    };
    hyprland = {
      enable = lib.mkEnableOption "hyprland";
    };
    nvidia = {
      enable = lib.mkEnableOption "nvidia";
    };
  };
}
