{...}: {
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    secrets.wghome_conf = {
      mode = "600";
      path = "/etc/wireguard/wghome.conf";
    };
  };
}
