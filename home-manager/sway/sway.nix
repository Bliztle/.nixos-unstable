{pkgs, ...}: {
  home.packages = with pkgs; [
    kitty
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    checkConfig = false;
  };
}
