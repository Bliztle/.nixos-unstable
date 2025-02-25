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

  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      ips = [ "10.100.0.2/24" ];
      listenPort = 51820; # to match firewall allowedUDPPorts (without this wg uses random port numbers)

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/run/secrets/wg0_private";
      # privateKey = builtins.readFile /

      peers = [
        # For a client configuration, one peer entry for the server will suffice.

        {
          # Public key of the server (not a file path).
          publicKey = "IkfpwQNSx8V2p/TNH7pYkI4PbhbDPm315xTiz03jp1E=";

          # Forward specific traffic
          allowedIPs = [ "10.0.0.2/24" "10.100.0.2/24" ];

          # Set this to the server IP and port.
          endpoint = "home.bliztle.com:51820"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
