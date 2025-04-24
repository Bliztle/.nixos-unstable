{ ... }:

{
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    secrets.yubico_u2f_keys = {
      mode = "0466"; # Allow access
      owner = "bliztle";
      path = "/home/bliztle/.config/Yubico/u2f_keys";
    };

    secrets.k3s_config = {
      mode = "0466"; # Allow access
      path = "/home/bliztle/.kube/config";
    };

    secrets.expressvpn_activation_code = {};
    secrets.wg0_public = {};
    secrets.wg0_private = {};
    secrets.wg0_conf = {
      mode = "600";
      path = "/etc/wireguard/wg0.conf";
    };
    secrets.wghome_conf = {
      mode = "600";
      path = "/etc/wireguard/wghome.conf";
    };
  };
}
