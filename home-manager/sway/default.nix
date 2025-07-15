{
  conf,
  pkgs,
  ...
}: let
  configDir = ./config; # This is a path to a dir with files
  configNames = builtins.attrNames (builtins.readDir configDir);
  readFile = name: builtins.readFile (configDir + "/${name}");
  config = builtins.concatStringsSep "\n" (map readFile configNames);

  hostPath = ./hosts/${conf.custom.hostname}.conf;
  hostConfig =
    if builtins.pathExists hostPath
    then builtins.readFile hostPath
    else "";
in {
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    checkConfig = false;
    config = null; # Do not use the default config
    extraConfigEarly = hostConfig;
    extraConfig = config;
  };
}
