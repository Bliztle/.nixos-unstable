{lib, ...}: {
  options.custom = {
    hostname = lib.mkOption {
      type = lib.types.str;
      description = "The hostname for the system.";
    };
    hyprland = {
      enable = lib.mkEnableOption "hyprland";
    };
  };
}
