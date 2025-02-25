{ ... }:

{
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    secrets.yubico_u2f_keys = {
      mode = "0466"; # Allow access
      owner = "bliztle";
      path = "/home/bliztle/.config/Yubico/u2f_keys";
    };

    secrets.wg0_public = {};
    secrets.wg0_private = {};
  };
}
