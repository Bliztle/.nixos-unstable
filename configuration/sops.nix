{ ... }:
{
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    # secrets.k3s_config = {
    #   mode = "0466"; # Allow access
    #   path = "/home/bliztle/.kube/config";
    # };
    secrets.wghome_conf = {
      mode = "600";
      path = "/etc/wireguard/wghome.conf";
    };
  };
}
