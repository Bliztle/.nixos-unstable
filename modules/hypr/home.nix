{ inputs, pkgs, lib, cfg, ... }:

{
  # Since hyprland.conf is simply linked, plugins are handled by linking them to a known location and referencing that in conf
  home.file.".config/extra/hypr/plugins/hy3" =  lib.mkIf cfg.custom.hyprland.enable {
    source = inputs.hy3.packages.${pkgs.system}.hy3;
    recursive = true;
    force = true;
  };
}
