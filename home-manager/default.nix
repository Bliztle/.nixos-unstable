{
  config,
  inputs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.default];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = {
    inherit inputs;
    # Make NixOs configuration available to home-manager modules
    conf = config;
  };

  home-manager.sharedModules = [
    inputs.nvf.homeManagerModules.default
    inputs.nixvim.homeModules.default
  ];

  home-manager.users.bliztle = import ./home.nix;
}
