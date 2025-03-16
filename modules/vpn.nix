{ ... }:

{
  networking.firewall = {
    allowedUDPPorts = [ 51820 ]; # WG: Clients and peers can use the same port, see listenport
  };

  services.openvpn.servers = {
    express_denmark = {
      config = ''
        config /root/.vpn/my_expressvpn_denmark_udp.ovpn
      '';
    };
  };
}
