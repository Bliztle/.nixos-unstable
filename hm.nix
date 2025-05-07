{ config, inputs, ... }: {
  imports = [ inputs.home-manager.nixosModules.default ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = {
    inherit inputs;
    cfg = config;
  };
  
  home-manager.sharedModules = [
    inputs.nvf.homeManagerModules.default
  ];

  home-manager.users.bliztle = import ./home.nix;
}
