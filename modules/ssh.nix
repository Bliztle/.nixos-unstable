{ ... }:

# Agent needs to be started from configuration.nix
# Enabling services.ssh-agent in HM does not play well with _SK keys

{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "confirm";

    matchBlocks = {
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
