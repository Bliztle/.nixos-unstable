{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    auto-cpufreq.url = "github:AdnanHodzic/auto-cpufreq";
    sops-nix.url = "github:Mic92/sops-nix";
    nixvim.url = "github:nix-community/nixvim";

    tapaal.url = "github:bliztle/tapaal-nix";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    auto-cpufreq.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      auto-cpufreq,
      sops-nix,
      ...
    }@inputs:
    {
      nixosConfigurations =
        let
          sharedModules = [
            ./options.nix
            ./configuration
            ./home-manager
            auto-cpufreq.nixosModules.default
            sops-nix.nixosModules.sops
          ];
        in
        {
          zenbook = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            specialArgs = { inherit inputs; };
            modules = sharedModules ++ [
              ./hosts/zenbook
            ];
          };
          framework = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            specialArgs = { inherit inputs; };
            modules = sharedModules ++ [
              ./hosts/framework
            ];
          };
          omen = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            specialArgs = { inherit inputs; };
            modules = sharedModules ++ [
              ./hosts/omen
            ];
          };
        };
    };
}
