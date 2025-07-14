{ ... }:

{
  fileSystems."/mnt/nas/default" = {
    device = "10.0.0.13:/volume1/default";  # Replace with NAS IP & path
    fsType = "nfs";
    options = [ "vers=4" "nofail" "_netdev" "x-systemd.automount" "x-systemd.idle-timeout=600" ];
  };
  fileSystems."/mnt/nas/media" = {
    device = "10.0.0.13:/volume1/media";  # Replace with NAS IP & path
    fsType = "nfs";
    options = [ "vers=4" "nofail" "_netdev" "x-systemd.automount" "x-systemd.idle-timeout=600" ];
  };
}
