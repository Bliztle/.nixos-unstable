{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nixpkgs-stable.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.xz";
    # Zotero 10.0.4 with its ESR 140 runtime; keep until stable catches up.
    zotero-pinned.url = "https://releases.nixos.org/nixos/unstable/nixos-26.11pre1097682.02c087f3fe67/nixexprs.tar.xz";
    home-manager.url = "github:nix-community/home-manager";
    sops-nix.url = "github:Mic92/sops-nix";
    nixvim.url = "github:nix-community/nixvim";

    tapaal.url = "github:bliztle/tapaal-nix";
    llm-agents.url = "github:numtide/llm-agents.nix";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
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
