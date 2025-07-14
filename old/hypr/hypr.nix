{ inputs, pkgs, lib, config, ... }:

{

  # options.custom.hyprland = {
  #   enable = lib.mkEnableOption "hyprland";
  # };

  config = lib.mkIf config.custom.hyprland.enable {
    programs.hyprland = {
      enable = true;
      # set the flake package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      # Recommended setting by description in man configuration.nix
      withUWSM = true;
    };

    # Enable cachix to avoid building. It is not included in hydra's cache
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  };
}
