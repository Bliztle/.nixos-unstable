{ pkgs, ... }:
# Agent needs to be started from configuration.nix
# Enabling services.ssh-agent in HM does not play well with _SK keys
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
        # AddKeysToAgent = "confirm";
        ForwardAgent = true;
      };
      "gateway.home" = {
        # lenovo.home from outside the house
        HostName = "home.bliztle.com";
        User = "nixos";
        ForwardAgent = true;
        # Port = 12172;
      };
      "gateway2.home" = {
        # lenovo.home from outside the house
        HostName = "home-bliztle.dynamic-dns.net";
        User = "nixos";
        ForwardAgent = true;
        # Port = 12172;
      };
      "zenbook.home" = {
        HostName = "10.0.0.8";
        User = "nixos";
        ForwardAgent = true;
      };
      "lenovo.home" = {
        HostName = "10.0.0.7";
        User = "nixos";
        ForwardAgent = true;
      };
      "pi.home" = {
        HostName = "10.0.0.6";
        User = "nixos";
        ForwardAgent = true;
      };
      "manfred" = {
        HostName = "manfred.datalogi.net";
        User = "manfred";
        ForwardAgent = true;
        ProxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };
    };
  };
}
