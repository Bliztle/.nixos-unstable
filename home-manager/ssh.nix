{...}:
# Agent needs to be started from configuration.nix
# Enabling services.ssh-agent in HM does not play well with _SK keys
{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "confirm";

    matchBlocks = {
      "gateway.home" = {
        # lenovo.home from outside the house
        hostname = "home.bliztle.com";
        user = "nixos";
        forwardAgent = true;
        # port = 12172;
      };
      "gateway2.home" = {
        # lenovo.home from outside the house
        hostname = "home-bliztle.dynamic-dns.net";
        user = "nixos";
        forwardAgent = true;
        # port = 12172;
      };
      "zenbook.home" = {
        hostname = "10.0.0.8";
        user = "nixos";
        forwardAgent = true;
      };
      "lenovo.home" = {
        hostname = "10.0.0.7";
        user = "nixos";
        forwardAgent = true;
      };
      "pi.home" = {
        hostname = "10.0.0.6";
        user = "nixos";
        forwardAgent = true;
      };
    };
  };
}
