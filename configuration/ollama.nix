{lib, config, ...}: {
  services.ollama = lib.mkIf config.custom.nvidia.enable {
    enable = true;
    loadModels = [ "qwen2.5-coder:latest" ];
  };
}
