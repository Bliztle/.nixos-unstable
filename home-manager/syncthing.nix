{ lib, conf, ... }:
lib.mkIf conf.custom.syncthing.enable {
  services.syncthing = {
    enable = true;
    settings = {
      devices.zenbook = {
        id = "TN5QXTU-6MCSUDY-5Y7ARL5-D7P6KOM-SUBGJYU-BOJYDL7-KTKJY5F-2A3FKQG";
        addresses = [
          "dynamic"
          "tcp://syncthing.bliztle.com:22000"
          "tcp://10.0.0.8:22000"
        ];
        compression = "metadata";
        introducer = true;
      };

      devices.framework = {
        id = "7VE4AEN-CYY4UKI-R7GH3BB-PJOVQEB-JE5EDRT-L2JPWSB-RT3VEWT-ZOFYVQA"; # Replace with actual device ID
        addresses = [ "dynamic" ];
        compression = "metadata";
      };

      devices.omen = {
        id = "REPLACE_WITH_ID"; # Replace with actual device ID
        addresses = [ "dynamic" ];
        compression = "metadata";
      };

      folders."uni" = {
        devices = [
          "zenbook"
          "framework"
          "omen"
        ];
        versioning.type = "trashcan";
        path = "~/uni";
      };
      options.urAccepted = -1;
    };
  };
}
