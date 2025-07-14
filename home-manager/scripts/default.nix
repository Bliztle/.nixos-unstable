{
  pkgs,
  lib,
  ...
}: let
  scriptPath = ".config/scripts";
in {
  home.sessionPath = ["$HOME/${scriptPath}" "$HOME/${scriptPath}2"];
  xdg.configFile."scripts" = {
    recursive = true;
    source = ./src;
  };

  # Start plasma session
  home.file."${scriptPath}2/start-plasma" = {
    text = ''
      #!/usr/bin/env bash
      ${pkgs.kdePackages.plasma-workspace}/libexec/plasma-dbus-run-session-if-needed ${pkgs.kdePackages.plasma-workspace}/bin/startplasma-wayland
    '';
    executable = true;
  };

  # Start typst watch and view pdf
  home.file."${scriptPath}2/typst-watch" = {
    text = ''
      #!/usr/bin/env bash
      ${pkgs.zathura}/bin/zathura $1.pdf &
      ${pkgs.typst}/bin/typst watch $1.typ
    '';
    executable = true;
  };
}
