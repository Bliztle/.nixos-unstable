{ pkgs, lib, ... }:
let
  scriptPath = ".config/scripts";
in
{
  home.sessionPath = [ "$HOME/${scriptPath}" "$HOME/${scriptPath}2" ];
  xdg.configFile."scripts" = {
    recursive = true;
    source = ./src;
  };

  home.file."${scriptPath}2/start-plasma" = {
    text = ''
      #!/usr/bin/env bash
      ${pkgs.kdePackages.plasma-workspace}/libexec/plasma-dbus-run-session-if-needed ${pkgs.kdePackages.plasma-workspace}/bin/startplasma-wayland
    '';
    executable = true;
  };
}
