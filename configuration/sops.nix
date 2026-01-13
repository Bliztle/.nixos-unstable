{ ... }:
{
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    secrets.wghome_conf = {
      mode = "600";
      path = "/etc/wireguard/wghome.conf";
    };
    secrets.nu_env = {
      mode = "666";
      path = "/home/bliztle/.config/nushell/env.secret.nu";
    };
  };
}
