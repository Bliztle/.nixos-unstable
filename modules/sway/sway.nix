{ pkgs, lib, config, ... }:

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
          pos = "2694 1440"; # Position this relative to home setup
          res = "1920x1080";
        };

        # Portable
        "ASUSTek COMPUTER INC ASUS MB14AHD R2LMTF057922" = {
          pos = "4614 1440"; # Position this relative to builtin
          res = "1920x1080";
        };

        # Omen
        "HP Inc. OMEN by HP 25 3CQ80417Q9" = {
          pos = "0 360";
          mode = "1920x1080@60Hz";
        };
        
        # Wide AOC
        "AOC U34G2G4R3 0x00001E0D" = {
          pos = "1920 0";
          mode = "3440x1440@144Hz";
        };

        # Vertical AOC 
        "AOC 27G2G4 GYGM3HA335541" = {
          pos = "5360 0";
          mode = "1920x1080@60Hz";
          transform = "270";
        };
        
      };

      # Bar
      bars = [
      {
        command = "waybar";
      }
      ];

      # Modes


      # Widgets


      # Assigns



      # Binds
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
        pactl = "${pkgs.pulseaudio}/bin/pactl";
        playerctl = "${pkgs.playerctl}/bin/playerctl";
        menu = "${pkgs.wofi}/bin/wofi --show drun --allow-images --allow-markup --insensitive --lines 8 --width 30% --line-wrap word --term kitty --location center --key-expand Tab --sort-order alphabetical --gtk-dark --hide-scroll --display-generic false --print-command --layer overlay --show-all --prompt ''";
      in lib.mkOptionDefault { # mkOptionDefault handles merging with default settings
        "${modifier}+space" = "exec ${menu}";

        # Screenshot
        "${modifier}+Print" = "exec sway-screenshot -m window"; # Window
        "Print" = "exec sway-screenshot -m output"; # 
        # "${modifier}+Shift+Print" = "exec sway-screenshot -m region";
        "${modifier}+Shift+Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";

        # Media control
        "XF86MonBrightnessDown" = "exec light -U 10";
        "XF86MonBrightnessUp" = "exec light -A 10";
        "XF86AudioRaiseVolume" = "exec '${pactl} set-sink-volume @DEFAULT_SINK@ +1%'";
        "XF86AudioLowerVolume" = "exec '${pactl} set-sink-volume @DEFAULT_SINK@ -1%'";
        "XF86AudioMute" = "exec '${pactl} set-sink-mute @DEFAULT_SINK@ toggle'";
        "XF86AudioMicMute" = "exec ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86AudioPlay" = "exec ${playerctl} play-pause";
        "XF86AudioNext" = "exec ${playerctl} next";
        "XF86AudioPrev" = "exec ${playerctl} previous";
        "XF86Search" = "exec bemenu-run";
      };


      # Startup
      startup = [
      {
        # Rotate backgrounds
        command = "swww init && swww-rotate";
      }
      {
        # Autotiling
        always = true;
        command = "${pkgs.autotiling}/bin/autotiling";
      }
      ];
    };
  };
}
