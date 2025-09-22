{ ... }:
{
  custom = {
    hostname = "omen";
    desktop = true;
    nvidia.enable = true;
    ollama.enable = true;
    syncthing.enable = true;
    gaming.gamescope = {
      enable = true;
      width = 3440;
      height = 1440;
      refreshRate = 144;
    };
  };
}
