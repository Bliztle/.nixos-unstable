{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    auto-cpufreq.url = "github:AdnanHodzic/auto-cpufreq";
    hyprland.url = "github:hyprwm/Hyprland";
    hy3.url = "github:outfoxxed/hy3";
    sops-nix.url = "github:Mic92/sops-nix";
    nvf.url = "github:Bliztle/nvf/emmet-language-server";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    auto-cpufreq.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    hy3.inputs.hyprland.follows = "hyprland";
  };

  outputs = {
    nixpkgs,
    home-manager,
    auto-cpufreq,
    hyprland,
    hy3,
    sops-nix,
    nvf,
    ...
  } @ inputs: {
    nixosConfigurations = {
      zenbook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {inherit inputs;};
        modules = [
          ./options.nix
          ./hosts/zenbook
          ./configuration
          ./home-manager
          auto-cpufreq.nixosModules.default
          sops-nix.nixosModules.sops
        ];
      };
      framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {inherit inputs;};
        modules = [
          ./options.nix
          ./hosts/framework
          ./configuration
          ./home-manager
          auto-cpufreq.nixosModules.default
          sops-nix.nixosModules.sops
        ];
      };
      omen = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {inherit inputs;};
        modules = [
          ./options.nix
          ./hosts/omen
          ./configuration
          ./home-manager
          auto-cpufreq.nixosModules.default
          sops-nix.nixosModules.sops
        ];
      };
    };
  };
}
