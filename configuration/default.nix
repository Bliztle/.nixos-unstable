{ config, inputs, pkgs, ... }: {
  # A separate package set for opting individual applications into stable.
  _module.args.stablePkgs = import inputs.nixpkgs-stable {
    system = pkgs.stdenv.hostPlatform.system;
    config = config.nixpkgs.config;
  };

  imports = [
    ./configuration.nix
    ./auth-notifications.nix
  ];
}
