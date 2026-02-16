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

  environment.systemPackages = with pkgs; [
    (lutris.override {
      # Extra is for dependencies required by games, not by lutris itself
      extraLibraries = pkgs: [
        # List library dependencies here
      ];
      extraPkgs = pkgs: [
        # List package dependencies here
      ];
    })
  ];
}
