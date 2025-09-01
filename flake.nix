{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    auto-cpufreq.url = "github:AdnanHodzic/auto-cpufreq";
    hyprland.url = "github:hyprwm/Hyprland";
    hy3.url = "github:outfoxxed/hy3";
    sops-nix.url = "github:Mic92/sops-nix";
    nvf.url = "github:Bliztle/nvf/emmet-language-server";
    nixvim.url = "github:nix-community/nixvim";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    auto-cpufreq.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    hy3.inputs.hyprland.follows = "hyprland";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    auto-cpufreq,
    hyprland,
    hy3,
    sops-nix,
    nvf,
    nixvim,
    ...
  } @ inputs: {
    nixosConfigurations = let
      sharedModules = [
        ./options.nix
        ./configuration
        ./home-manager
        auto-cpufreq.nixosModules.default
        sops-nix.nixosModules.sops
      ];
    in {
      zenbook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {inherit inputs;};
        modules =
          sharedModules
          ++ [
            ./hosts/zenbook
          ];
      };
      framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {inherit inputs;};
        modules =
          sharedModules
          ++ [
            ./hosts/framework
          ];
      };
      omen = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {inherit inputs;};
        modules =
          sharedModules
          ++ [
            ./hosts/omen
          ];
      };
    };
  };
}
