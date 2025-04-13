{ ... }:

# Nixos module, not HM
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  services.flatpak.enable = true;
}
