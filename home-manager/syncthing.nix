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
        id = "7VE4AEN-CYY4UKI-R7GH3BB-PJOVQEB-JE5EDRT-L2JPWSB-RT3VEWT-ZOFYVQA";
        compression = "metadata";
      };

      devices.omen = {
        id = "MXOAWAD-CX3FCZK-RRVNVZZ-PJYAJAS-NH3FRPQ-NJGEO3X-XG6KWWY-26G6YAC";
        compression = "metadata";
      };
      folders = {
        "uni" = {
          devices = [
            "zenbook"
            "framework"
            "omen"
          ];
          versioning.type = "trashcan";
          path = "~/uni";
        };
        "synced" = {
          devices = [
            "zenbook"
            "framework"
            "omen"
          ];
          versioning.type = "trashcan";
          path = "~/.synced";
        };
      };
      options.urAccepted = -1;
    };
  };
}
