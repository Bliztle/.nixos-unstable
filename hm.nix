{ config, inputs, ... }: {
  imports = [ inputs.home-manager.nixosModules.default ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = {
    inherit inputs;
    cfg = config; # Now this works, because `config` is available!
  };

  home-manager.users.bliztle = import ./home.nix;
}
