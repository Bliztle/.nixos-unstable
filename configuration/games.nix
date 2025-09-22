{ pkgs, config, ... }:
# Nixos module, not HM
{
  programs.gamescope = {
    enable = config.custom.gaming.gamescope.enable;
    args = [
      "-f"
      "-W ${toString config.custom.gaming.gamescope.width}"
      "-H ${toString config.custom.gaming.gamescope.height}"
      "-r ${toString config.custom.gaming.gamescope.refreshRate}"
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
}
