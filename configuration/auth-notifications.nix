{ config, pkgs, ... }:
let
  fingerprintNotification = pkgs.writeText "fingerprint-notification.sh" ''
    uid=$(${pkgs.coreutils}/bin/id -u -- "$PAM_USER") || exit 0
    [[ -S /run/user/$uid/bus ]] || exit 0

    # Our parent is timeout; its parent is the authenticating sudo process.
    while read -r key value; do
      [[ $key == PPid: ]] && requester=$value
    done < /proc/$PPID/status
    mapfile -d "" -t argv < /proc/$requester/cmdline || exit 0
    command="''${argv[*]}"
    command="''${command:0:240}"
    command="''${command//&/\&amp;}"
    command="''${command//</\&lt;}"
    command="''${command//>/\&gt;}"

    exec ${pkgs.util-linux}/bin/runuser -u "$PAM_USER" -- \
      ${pkgs.coreutils}/bin/env -i \
      DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$uid/bus" \
      ${pkgs.libnotify}/bin/notify-send --app-name=Authentication \
      --icon=dialog-password --expire-time=10000 \
      "sudo: scan your fingerprint" "$command"
  '';
in
{
  programs.yubikey-touch-detector = {
    enable = true;
    libnotify = true;
  };

  # PAM rules are experimental NixOS options: review ordering on upgrades.
  security.pam.services = pkgs.lib.genAttrs [ "sudo" "sudo-i" ] (service: {
    rules.auth.fingerprint-notification = {
      enable = config.security.pam.services.${service}.fprintAuth;
      order = config.security.pam.services.${service}.rules.auth.fprintd.order - 1;
      # Notification delivery must never change the authentication result.
      control = "[default=ignore]";
      modulePath = "${config.security.pam.package}/lib/security/pam_exec.so";
      args = [
        "quiet"
        "seteuid"
        "${pkgs.coreutils}/bin/timeout"
        "1s"
        "${pkgs.bash}/bin/bash"
        "-p" # Ignore shell startup files and shell options from PAM's environment.
        "${fingerprintNotification}"
      ];
    };
  });
}
