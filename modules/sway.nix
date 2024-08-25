{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "kitty";

      # Inputs
      input = {
        "type:keyboard" = {
          xkb_layout = "dk";
        };
        "7504:24926:ZMK_Project_Corne42k_Keyboard" = {
          xkb_layout = "us";
        };
      };

      # Outputs
      output = {
        # Built-in monitor
        "AU Optronics 0xA48F Unknown" = {
          pos = "0 0";
          res = "1920x1080";
        };

        "ASUSTek COMPUTER INC ASUS MB14AHD R2LMTF057922" = {
          pos = "1920 0";
          res = "1920x1080";
        };
      };

      # Modes


      # Widgets


      # Binds
      # keybindings = {
      #   "Mod1+space" = "exec $menu";
      # };


      # Startup
      startup = [
      {
        command = "swww init && swww-rotate";
      }
      ];
    };
  };
}
