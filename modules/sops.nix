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
    secrets.wg0_conf = {
      mode = "600";
      path = "/etc/wireguard/wg0.conf";
    };
  };
}
