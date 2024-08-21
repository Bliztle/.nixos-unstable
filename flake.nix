{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      zenbook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

	specialArgs = { inherit inputs; };
	modules = [
	  ./hardware-configuration.nix
	  ./configuration.nix
	  home-manager.nixosModules.default {
            home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.bliztle = import ./home.nix;
	  }
	];
      };
    };
  };
}
