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

  # # TODO: Make this work. Probably just needs to activate AFTER ovpn, as later manual activation works fine
  # # Current configuration is entirely in sops

  # networking.wireguard.interfaces = {
  #   wg0 = {
  #     # Determines the IP address and subnet of the client's end of the tunnel interface.
  #     ips = [ "10.100.0.2/24" ];
  #     listenPort = 51820; # to match firewall allowedUDPPorts (without this wg uses random port numbers)
  #     privateKeyFile = "/run/secrets/wg0_private";
  #     # privateKey = builtins.readFile /
  #
  #     peers = [
  #       {
  #         # Public key of the server (not a file path).
  #         publicKey = "yUEECpTMwwbnkezCtIRhRMax057m5eliNILUauXy2gM=";
  #
  #         # Forward specific traffic
  #         allowedIPs = [ "10.0.0.0/24" "10.100.0.0/24" ];
  #
  #         # Set this to the server IP and port.
  #         endpoint = "home.bliztle.com:51820"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577
  #
  #         # Send keepalives every 25 seconds. Important to keep NAT tables alive.
  #         persistentKeepalive = 25;
  #       }
  #     ];
  #   };
  # };

  # systemd.services.openvpn-client-express_denmark = {
  # systemd.services."openvpn-express_denmark.service" = {
  #   after = [ "networking.service" "wg-quick-wg0.service" ];
  #   wants = [ "wg-quick-wg0.service" ];
  # };
}
