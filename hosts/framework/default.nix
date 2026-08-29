{...}: {
  imports = [
    ./options.nix
    ./hardware-configuration.nix
  ];

  # State version should be version of iso used to install nixos
  # I have yet to find another reason to update it
  system.stateVersion = "26.05";
}
