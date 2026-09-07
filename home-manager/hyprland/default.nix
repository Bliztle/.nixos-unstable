{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  lua = lib.generators.mkLuaInline;
  wallpaper = ../config/wallpapers/inactive/purple/purple_sunset.jpg;

  bind = keys: action: {
    _args = [
      keys
      (lua action)
    ];
  };
  bindWithFlags = keys: action: flags: {
    _args = [
      keys
      (lua action)
      flags
    ];
  };

  directions = [
    {
      key = "h";
      direction = "l";
      nativeDirection = "left";
    }
    {
      key = "j";
      direction = "d";
      nativeDirection = "down";
    }
    {
      key = "k";
      direction = "u";
      nativeDirection = "up";
    }
    {
      key = "l";
      direction = "r";
      nativeDirection = "right";
    }
    {
      key = "left";
      direction = "l";
      nativeDirection = "left";
    }
    {
      key = "down";
      direction = "d";
      nativeDirection = "down";
    }
    {
      key = "up";
      direction = "u";
      nativeDirection = "up";
    }
    {
      key = "right";
      direction = "r";
      nativeDirection = "right";
    }
  ];

  directionBinds = lib.concatMap (direction: [
    (bind "SUPER + ${direction.key}" ''hl.dsp.focus({ direction = "${direction.nativeDirection}" })'')
    (bind "SUPER + SHIFT + ${direction.key}" "hl.plugin.hy3.move_window(\"${direction.direction}\")")
  ]) directions;

  workspaceBinds = lib.concatMap (workspace: [
    (bind "SUPER + ${toString (lib.mod workspace 10)}" "hl.dsp.focus({ workspace = ${toString workspace} })")
    (bind "SUPER + SHIFT + ${toString (lib.mod workspace 10)}" "hl.plugin.hy3.move_to_workspace(\"${toString workspace}\")")
  ]) (lib.range 1 10);

  resizeBinds =
    let
      resize =
        key: x: y:
        bindWithFlags key "hl.dsp.window.resize({ x = ${toString x}, y = ${toString y}, relative = true })"
          { repeating = true; };
    in
    [
      (bind "Escape" "hl.dsp.submap(\"reset\")")
      (bind "Return" "hl.dsp.submap(\"reset\")")
      (resize "Down" 0 10)
      (resize "Left" (-10) 0)
      (resize "Right" 10 0)
      (resize "Up" 0 (-10))
      (resize "h" (-10) 0)
      (resize "j" 0 10)
      (resize "k" 0 (-10))
      (resize "l" 10 0)
      (resize "SHIFT + Down" 0 100)
      (resize "SHIFT + Left" (-100) 0)
      (resize "SHIFT + Right" 100 0)
      (resize "SHIFT + Up" 0 (-100))
      (resize "SHIFT + h" (-100) 0)
      (resize "SHIFT + j" 0 100)
      (resize "SHIFT + k" 0 (-100))
      (resize "SHIFT + l" 100 0)
    ];
in
{
  home.packages = with pkgs; [
    hyprpaper
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";
    systemd.enable = false;

    plugins = [
      inputs.hy3.packages.${system}.hy3
    ];

    settings = {
      curve = [
        {
          _args = [
            "easeOutQuint"
            {
              type = "bezier";
              points = [
                [
                  0.23
                  1
                ]
                [
                  0.32
                  1
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "almostLinear"
            {
              type = "bezier";
              points = [
                [
                  0.5
                  0.5
                ]
                [
                  0.75
                  1
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "quick"
            {
              type = "bezier";
              points = [
                [
                  0.15
                  0
                ]
                [
                  0.1
                  1
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "linear"
            {
              type = "bezier";
              points = [
                [
                  0
                  0
                ]
                [
                  1
                  1
                ]
              ];
            }
          ];
        }
      ];

      animation = [
        {
          leaf = "global";
          enabled = true;
          speed = 5;
          bezier = "default";
        }
        {
          leaf = "windows";
          enabled = true;
          speed = 3.5;
          bezier = "quick";
        }
        {
          leaf = "windowsIn";
          enabled = true;
          speed = 3;
          bezier = "easeOutQuint";
          style = "popin 92%";
        }
        {
          leaf = "windowsOut";
          enabled = true;
          speed = 1.4;
          bezier = "linear";
          style = "popin 92%";
        }
        {
          leaf = "fadeIn";
          enabled = true;
          speed = 2;
          bezier = "almostLinear";
        }
        {
          leaf = "fadeOut";
          enabled = true;
          speed = 1.2;
          bezier = "linear";
        }
        {
          leaf = "layersIn";
          enabled = true;
          speed = 2.5;
          bezier = "easeOutQuint";
          style = "fade";
        }
        {
          leaf = "layersOut";
          enabled = true;
          speed = 1.2;
          bezier = "linear";
          style = "fade";
        }
        {
          leaf = "workspaces";
          enabled = true;
          speed = 2.2;
          bezier = "quick";
          style = "slidefade 15%";
        }
      ];

      config = {
        general = {
          layout = "hy3";
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          resize_on_border = true;
          col = {
            active_border = {
              colors = [
                "rgba(c678ddee)"
                "rgba(61afefff)"
              ];
              angle = 45;
            };
            inactive_border = "rgba(53596588)";
          };
        };

        decoration = {
          rounding = 8;
          rounding_power = 2;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = 1712592932;
          };
          blur = {
            enabled = true;
            size = 4;
            passes = 2;
            vibrancy = 0.1;
          };
        };

        input = {
          kb_layout = "us,dk,us";
          kb_variant = "altgr-intl,,colemak_dh";
          kb_options = "grp:alt_shift_toggle,caps:swapescape";
          touchpad = {
            tap_to_click = true;
            natural_scroll = true;
          };
        };
      };

      monitor = [
        {
          output = "desc:BOE NE135A1M-NY1";
          mode = "2880x1920@120";
          position = "2400x1440";
          scale = 1.33;
        }
        {
          output = "desc:ASUSTek COMPUTER INC ASUS MB14AHD R2LMTF057922";
          mode = "1920x1080";
          position = "4614x1440";
          scale = 1;
        }
        {
          output = "desc:HP Inc. OMEN by HP 25 3CQ80417Q9";
          mode = "1920x1080@60";
          position = "0x360";
          scale = 1;
        }
        {
          output = "desc:AOC U34G2G4R3 0x00001E0D";
          mode = "3440x1440@120";
          position = "1920x0";
          scale = 1;
        }
        {
          output = "desc:AOC 27G2G4 GYGM3HA335541";
          mode = "1920x1080@60";
          position = "5360x0";
          scale = 1;
          transform = 3;
        }
        {
          output = "desc:Lenovo Group Limited P27q-20 V909LR00";
          mode = "2560x1440@60";
          position = "2218x0";
          scale = 1;
        }
        {
          output = "desc:Lenovo Group Limited P27q-20 V909LPXM";
          mode = "2560x1440@60";
          position = "4778x0";
          scale = 1;
        }
        {
          output = "desc:Lenovo Group Limited T27h-30 V5PZV660";
          mode = "2560x1440@60";
          position = "4778x0";
          scale = 1;
        }
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = "auto";
        }
      ];

      on = {
        _args = [
          "hyprland.start"
          (lua ''
            function()
              hl.exec_cmd("uwsm app -- waybar")
              hl.exec_cmd("uwsm app -- hyprpaper")
            end
          '')
        ];
      };

      bind = [
        (bind "SUPER + space" "hl.dsp.exec_cmd(\"uwsm app -- wofi --show drun\")")
        (bind "SUPER + d" "hl.dsp.exec_cmd(\"uwsm app -- wofi --show drun\")")
        (bind "SUPER + Return" "hl.dsp.exec_cmd(\"uwsm app -- kitty\")")
        (bind "SUPER + SHIFT + Return" "hl.dsp.exec_cmd(\"uwsm app -- kitty --class floating-term\")")
        (bind "SUPER + SHIFT + q" "hl.dsp.window.close()")
        (bind "SUPER + r" "hl.dsp.submap(\"resize\")")
        (bind "SUPER + SHIFT + Print" "hl.dsp.exec_cmd(\"grimshot copy area\")")
        (bind "SUPER + SHIFT + r" "hl.dsp.exec_cmd(\"sway-record-region\")")
        (bind "SUPER + SHIFT + c" "hl.dsp.exec_cmd(\"hyprctl reload\")")

        (bindWithFlags "XF86MonBrightnessDown" "hl.dsp.exec_cmd(\"brightnessctl set 10%-\")" {
          repeating = true;
        })
        (bindWithFlags "XF86MonBrightnessUp" "hl.dsp.exec_cmd(\"brightnessctl set +10%\")" {
          repeating = true;
        })
        (bindWithFlags "XF86AudioRaiseVolume"
          "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+\")"
          {
            locked = true;
            repeating = true;
          }
        )
        (bindWithFlags "XF86AudioLowerVolume"
          "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-\")"
          {
            locked = true;
            repeating = true;
          }
        )
        (bindWithFlags "XF86AudioMute" "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\")" {
          locked = true;
        })
        (bindWithFlags "XF86AudioMicMute"
          "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle\")"
          { locked = true; }
        )
        (bindWithFlags "XF86AudioPlay" "hl.dsp.exec_cmd(\"playerctl play-pause\")" { locked = true; })
        (bindWithFlags "XF86AudioNext" "hl.dsp.exec_cmd(\"playerctl next\")" { locked = true; })
        (bindWithFlags "XF86AudioPrev" "hl.dsp.exec_cmd(\"playerctl previous\")" { locked = true; })

        (bind "SUPER + SHIFT + f" "hl.dsp.window.float()")
        (bind "SUPER + SHIFT + s" ''
          function()
            hl.dispatch(hl.dsp.window.float())
            hl.dispatch(hl.dsp.window.pin())
          end
        '')
        (bind "SUPER + b" "hl.plugin.hy3.make_group(\"h\")")
        (bind "SUPER + v" "hl.plugin.hy3.make_group(\"v\")")
        (bind "SUPER + w" "hl.plugin.hy3.change_group(\"toggletab\")")
        (bind "SUPER + e" "hl.plugin.hy3.change_group(\"opposite\")")
        (bind "SUPER + f" "hl.dsp.window.fullscreen()")
        (bind "SUPER + a" "hl.plugin.hy3.change_focus(\"raise\")")

        (bindWithFlags "SUPER + mouse:272" "hl.dsp.window.drag()" { mouse = true; })
        (bindWithFlags "SUPER + mouse:273" "hl.dsp.window.resize()" { mouse = true; })
      ]
      ++ directionBinds
      ++ workspaceBinds;

      window_rule = [
        {
          name = "picture-in-picture";
          match.title = "^Picture-in-Picture$";
          float = true;
          move = [
            877
            450
          ];
          pin = true;
        }
        {
          name = "pavucontrol-float";
          match.class = "^pavucontrol$";
          float = true;
        }
        {
          name = "steam-app-float";
          match.class = "^steam_app.*$";
          float = true;
        }
        {
          name = "floating-terminal";
          match.class = "^floating-term$";
          float = true;
          size = [
            400
            200
          ];
        }
        {
          name = "spotify-workspace";
          match.class = "^Spotify$";
          workspace = "4";
        }
        {
          name = "teams-workspace";
          match.class = "^teams-for-linux$";
          workspace = "4";
        }
        {
          name = "discord-workspace";
          match.class = "^discord$";
          workspace = "4";
        }
        {
          name = "proton-mail-workspace";
          match.class = "^Proton Mail$";
          workspace = "4";
        }
      ];

      layer_rule = [
        {
          match.namespace = "wofi";
          blur = true;
        }
        {
          match.namespace = "waybar";
          blur = false;
        }
      ];
    };

    submaps.resize.settings.bind = resizeBinds;
  };

  services.hyprpaper = {
    enable = true;
    package = null;
    settings.wallpaper = {
      monitor = "";
      path = toString wallpaper;
    };
  };
}
