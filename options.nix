{ lib, ... }:

{
  options.custom.hyprland = {
    enable = lib.mkEnableOption "hyprland";
  };
}
