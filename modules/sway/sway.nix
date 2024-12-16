{ pkgs, lib, config, ... }:
let
  outputs = {
    builtin = "AU Optronics 0xA48F Unknown";
    portable = "ASUSTek COMPUTER INC ASUS MB14AHD R2LMTF057922";
    omen = "HP Inc. OMEN by HP 25 3CQ80417Q9";
    wide = "AOC U34G2G4R3 0x00001E0D";
    vertical = "AOC 27G2G4 GYGM3HA335541";
    misc = {
      slv300-3-1-57 = "Samsung Electric Company SAMSUNG 0x01000E00";
    };
  };
  inputs = {
    corne_wired = "7504:24926:ZMK_Project_Corne42k_Keyboard";
    corne_bluetooth = "7504:24926:Corne42k_Keyboard";
    portable_touch = "1267:12113:ELAN_Touchscreen";
    portable_stylus = "1267:12113:ELAN_Touchscreen_Stylus";
  };
in
{
  home.packages = with pkgs; [
    kitty
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "kitty";
      # defaultWorkspace = "1: media";

      # Inputs
      input = let 
        corne_settings = {
          xkb_layout = "us";
        };
        touch_settings = {
          tap = "enabled";
          natural_scroll = "enabled";
          map_to_output = "'${outputs.portable}'";
          scroll_method = "two_finger";
        };
      in {
        "type:keyboard" = {
          xkb_layout = "dk,us(colemak_dh)";
          xkb_options = "grp:alt_shift_toggle";
        };
        "${inputs.corne_wired}" = corne_settings;
        "${inputs.corne_bluetooth}" = corne_settings;
        "${inputs.portable_touch}" = touch_settings;
        "${inputs.portable_stylus}" = touch_settings;
      };

      # Outputs
      output = {
        # Built-in monitor
        "${outputs.builtin}" = {
          pos = "2694 1440"; # Position this relative to home setup
          res = "1920x1080";
        };

        # Portable
        "${outputs.portable}"= {
          pos = "4614 1440"; # Position this relative to builtin
          res = "1920x1080";
        };

        # Omen
        "${outputs.omen}"= {
          pos = "0 360";
          mode = "1920x1080@144Hz";
        };
        
        # Wide AOC
        "${outputs.wide}"= {
          pos = "1920 0";
          mode = "3440x1440@144Hz";
        };

        # Vertical AOC 
        "${outputs.vertical}"= {
          pos = "5360 0";
          mode = "1920x1080@60Hz";
          transform = "270";
        };

        ### Elsewhere
        
        # Slv 300 3.1.57
        "${outputs.misc.slv300-3-1-57}" = {
          pos = "6534 1440";
          mode = "3840x2160@60Hz";
        };
      };

      window = {
        border = 0;
        titlebar = false;
        commands = [
          # {
          #   criteria = {
          #     app_id = "kitty";
          #   };
          #   command = "opacity 0.75";
          # }
          {
            criteria = {
              app_id = "firefox";
              title = "^Picture-in-Picture$";
            };
            command = "floating enable, move position 877 450, sticky enable";
          }
          {
            criteria = {
              app_id = "pavucontrol";
            };
            command = "floating enable";
            # command = "floating enable, sticky enable";
          }
          {
            criteria = {
              class = "steam_app";
            };
            command = "floating enable";
          }
        ];
      };

      gaps = {
        inner = 10;
      };

      workspaceOutputAssign = [
        # Home assigns
        {
          workspace = "1";
          output = "${outputs.builtin}";
        }
        {
          workspace = "2";
          output = "${outputs.omen}";
        }
        {
          workspace = "3";
          output = "${outputs.wide}";
        }
        {
          workspace = "4";
          output = "${outputs.vertical}";
        }

        # Portable assigns
        {
          workspace = "1";
          output = "${outputs.builtin}";
        }
        {
          workspace = "2";
          output = "${outputs.builtin}";
        }
        {
          workspace = "3";
          output = "${outputs.portable}";
        }
        {
          workspace = "4";
          output = "${outputs.portable}";
        }

        # Elsewhere assigns
        {
          workspace = "0";
          output = "${outputs.misc.slv300-3-1-57}";
        }
      ];

      # Bar
      bars = [
        {
          command = "waybar";
        }
      ];

      # Modes
      modes = {
        resize = {
          Escape = "mode default";
          Return = "mode default";
          Down = "resize grow height 10 px";
          Left = "resize shrink width 10 px";
          Right = "resize grow width 10 px";
          Up = "resize shrink height 10 px";
          h = "resize shrink width 10 px";
          j = "resize grow height 10 px";
          k = "resize shrink height 10 px";
          l = "resize grow width 10 px";
          "Shift+Down" = "resize grow height 100 px";
          "Shift+Left" = "resize shrink width 100 px";
          "Shift+Right" = "resize grow width 100 px";
          "Shift+Up" = "resize shrink height 100 px";
          "Shift+h" = "resize shrink width 100 px";
          "Shift+j" = "resize grow height 100 px";
          "Shift+k" = "resize shrink height 100 px";
          "Shift+l" = "resize grow width 100 px";
        };

        power = {
          Escape = "mode default";
          Return = "mode default";
          s = "exec shutdown now";
          r = "exec reboot";
          l = "exec swaylock";
        };
      };

      # Widgets

      # Assigns
      assigns = {
        "1" = [ # Media 
          {
            class = "spotify";
          }
        ];
        "4" = [ # Communication
          {
            class = "teams-for-linux";
          }
          {
            class = "discord";
          }
          {
            class = "Proton Mail";
          }
        ];
      };

      # Binds
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
        pactl = "${pkgs.pulseaudio}/bin/pactl";
        playerctl = "${pkgs.playerctl}/bin/playerctl";
        menu = "${pkgs.wofi}/bin/wofi --show drun --allow-images --allow-markup --insensitive --lines 8 --width 30% --line-wrap word --term kitty --location center --key-expand Tab --sort-order alphabetical --gtk-dark --hide-scroll --display-generic false --print-command --layer overlay --show-all --prompt ''";
      in lib.mkOptionDefault { # mkOptionDefault handles merging with default settings
        "${modifier}+space" = "exec ${menu}";
        "${modifier}+d" = "exec ${menu}";

        # Screenshot
        # "${modifier}+Print" = "exec sway-screenshot -m window"; # Window
        # "Print" = "exec sway-screenshot -m output"; # 
        "${modifier}+Shift+Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";

        "${modifier}+Shift+s" = "mode power";

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
      ];

    };

    extraConfig = ''
    output '${outputs.omen}' enable
    '';
  };
}
