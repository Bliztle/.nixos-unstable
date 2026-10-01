{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    sops-nix.url = "github:Mic92/sops-nix";
    nixvim.url = "github:nix-community/nixvim";

    # Existing runtime snapshot for Zotero's temporary Gecko 140 workaround.
    zotero-runtime.url = "github:NixOS/nixpkgs/0968519e14f7aa7d3e9b389682bd74d2b51c8ce8";

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
