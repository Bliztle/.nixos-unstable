{ lib, ... }:
{
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
    ollama = {
      enable = lib.mkEnableOption "ollama";
    };
    syncthing = {
      enable = lib.mkEnableOption "syncthing";
    };
    gaming = {
      gamescope = {
        enable = lib.mkEnableOption "gamescope";
        width = lib.mkOption {
          type = lib.types.int;
          description = "The width for gamescope.";
        };
        height = lib.mkOption {
          type = lib.types.int;
          description = "The height for gamescope.";
        };
        refreshRate = lib.mkOption {
          type = lib.types.int;
          description = "The refresh rate for gamescope.";
        };
      };
    };
  };
}
