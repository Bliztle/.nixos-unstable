# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/games.nix
    ];

  ##### Shell
  # It is 3 lines to enable zsh
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  ##### Audio / Sound
  security.rtkit.enable = true; # PulseAudio uses this for scheduling priority
  services.pipewire = {
    enable = true;
    # TODO: Enable these if there are audio issues
    # Pipewire docs recommended enabling the top 3
    alsa.enable = true; # Drivers and interfaces? Might not be required
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };

  ###### Yubikey configuration
  # TODO: Register keys declaratively
  security.pam.u2f = {
    enable = true;
    control = "sufficient"; # Do not ask for password if available
    settings = {
      debug = false; # Enable for logging
      cue = true;
    };
  };
  services.pcscd.enable = true; # Read yubikey certificates as smartcard. Required to get 30s 2fa keys

  # # Display Manager
  programs.sway.enable = true; # Register with dm. Configured in HM
  
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = lib.mkDefault {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
  };
  
  ##### Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  ##### Battery Optimisation
  services.power-profiles-daemon.enable = false; # Some DE's enable this
  programs.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        governor = "performance";
        turbo = "auto";
      };
      battery = {
        governor = "powersave";
        turbo = "auto";
      };
    };
  };

  programs.light.enable = true;

  ##### Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 5173 ];
  };

  ##### Misc security
  # SSH is defered to home-manager

  security.polkit.enable = true; # Allow raising privileges

  # gpg encryption agent
  programs.gnupg.agent = { 
    enable = true;
    # ssh support is disabled, as it requires using gpg subkeys instead of ssh keys
    # and interferes with pcscd, which may be used for smart card integration
  };

  ##### Misc
  virtualisation.docker.enable = true;
  programs.nix-ld.enable = true; # Allow dynamic linking of nix packages
  # security.pki.certificateFiles = [ # TODO: Why did this stop working?
  #   /etc/ssl/localcerts/localhost.crt
  # ];
  # services.expressvpn.enable = true;
  # Nerdfonts changed. This is now the way according to the error message???
  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  ##### Packages required by above configuration

  environment.systemPackages = with pkgs; [
    ###### Yubikey
    yubioath-flutter # 2FA gui for getting keys
    pam_u2f # General purpose pam u2f. Enough for yubikey 2fa
    yubikey-manager # Yubikey management tool - ykman
  ];





  ##### Default configuration

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "zenbook"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "dk";
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  users.users.bliztle = {
    isNormalUser = true;
    description = "Bliztle";
    extraGroups = [ "networkmanager" "wheel" "video" ]; # "video" is required to control laptop brightness
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  hardware = {
    graphics.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
