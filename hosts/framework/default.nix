{...}: {
  imports = [
    ./options.nix
    ./hardware-configuration.nix
  ];

  # The BIOS advertises an unwired ACP microphone; the built-in mic uses HDA.
  # Match the Framework 13 AI 300 workaround in nixos-hardware:
  # https://github.com/NixOS/nixos-hardware/issues/1603
  boot.blacklistedKernelModules = [
    "snd_acp70"
    "snd_acp_pci"
  ];

  # State version should be version of iso used to install nixos
  # I have yet to find another reason to update it
  system.stateVersion = "26.05";
}
