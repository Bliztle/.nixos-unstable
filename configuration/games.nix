{pkgs, ...}:
# Nixos module, not HM
{
  programs.gamescope = {
    enable = true;
    # TODO: Parameterise this for Omen resolution
    args = [
      "-f"
      "-W 2880"
      "-H 1920"
      "-r 120"
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
