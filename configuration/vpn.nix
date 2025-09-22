{ ... }:
{
  networking.firewall = {
    allowedUDPPorts = [ 51820 ]; # WG: Clients and peers can use the same port, see listenport
  };
}
