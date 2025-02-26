{ ... }:

{
  services.k3s = {
    enable = true;
    configPath = "/run/secrets/k3s_config";
  };
}
