{pkgs, ...}: {
  networking.firewall = {
    allowedUDPPorts = [51820]; # WG: Clients and peers can use the same port, see listenport
  };

  # Manual openvpn solution for express. Works more reliably than expressvpn cli, but is awkward when switching countries
  # services.openvpn.servers = {
  #   express_denmark = {
  #     config = ''
  #       config /root/.vpn/my_expressvpn_denmark_udp.ovpn
  #     '';
  #   };

  # ExpressVPN systemd service to automatically activate on boot. CLI is too unreliable by itself.
  # TODO: This doesn't actually work. The activation command does not correctly read the input
  systemd.services.expressvpn-auto-activate = let
    activationScript = pkgs.writeShellScript "expressvpn-auto-activate.sh" ''
      ACTIVATION_CODE=$(cat /run/secrets/expressvpn_activation_code)

      # If status is not connected, activate and connect
      if ! ${pkgs.expressvpn}/bin/expressvpn status 2>&1 | grep -q "Connected" \
        && ! ${pkgs.expressvpn}/bin/expressvpn status 2>&1 | grep -q "Disconnected"; then
        echo "ExpressVPN not activated. Attempting activation..."
        echo "$ACTIVATION_CODE" | ${pkgs.expressvpn}/bin/expressvpn activate # Activate client
        ${pkgs.expressvpn}/bin/expressvpn autoconnect true
      fi

      ### After connecting, ensure local dns is not routed through the vpn
      # Global DNS: Use expressvpn dns server, only accessible through tunnel
      resolvectl domain tun0 '~.'
      resolvectl dns tun0 100.64.100.1
      # Local DNS: route *.home & *.local to router
      resolvectl domain wlan0 '~home ~local'
      resolvectl dns wlan0 10.0.0.1
    '';
  in {
    description = "Ensure ExpressVPN is activated on boot";
    wantedBy = ["multi-user.target"];
    # 🔐 Ensure the secret is available before this service runs
    requires = ["sops-nix.service"];
    after = ["network.target" "sops-nix.service"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${activationScript}";
    };
  };
}
