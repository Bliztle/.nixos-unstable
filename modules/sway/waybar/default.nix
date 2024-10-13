{ pkgs, ... }:
{
  # waybar configuration from https://github.com/7KIR7/dots
  # Converted to nix by chatgpt
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
      layer = "top";
      position = "top";
      height = 33;
      margin = "3, 0, 2, 0";

      modules-left = [
        "custom/wmname"
        "sway/workspaces"
        "hyprland/workspaces"
        "sway/mode"
        "cpu"
        "custom/separator"
        "memory"
        "custom/separator"
        "network"
        "custom/separator"
        "temperature"
        "custom/recorder"
        "custom/audiorec"
      ];

      # modules-center = [ "custom/spotify" "tray" "mpd" ];
      modules-center = [ "custom/spotify" ];

      modules-right = [
        "idle_inhibitor"
        "custom/separator"
        "backlight"
        "custom/separator"
        "battery"
        "custom/separator"
        "pulseaudio"
        "custom/separator"
        "clock"
      ];

      # Modules configuration
      "sway/workspaces" = {
        disable-scroll = true;
        all-outputs = false;
        format = "{icon}";
        format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "7" = "";
            "8" = "";
            "9" = "";
            "urgent" = "";
            "focused" = "";
            "default" = "";
        };
      };

      "custom/wmname" = {
        format = "";
        tooltip = false;
      };

      "custom/separator" = {
        format = "|";
        interval = "once";
        tooltip = false;
      };

      "sway/mode" = {
        format =  "<span style=\"italic\">{}</span>";
        # format = "{icon}";
        # format-icons = {
        #   default = "\uf0c8";
        #   resize = "\uf065";
        #   move = "\uf0b2";
        #   floating = "\uf069";
        #   tiling = "\uf2d0";
        # };
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
            activated = " ";
            deactivated = " ";
        };
      };

      tray = {
        icon-size = 20;
        spacing = 6;
      };

      clock = {
        interval = 1;
        locale = "C";
        format = "   {:%I:%M %p}";
        format-alt = "  {:%a,%b %d}";
      };

    cpu = {
        format = "   {usage}%";
        tooltip = false;
        on-click = "kitty -e '${pkgs.htop}/bin/htop'";
    };

    memory = {
        interval = 30;
        format = "  {used:0.2f}GB";
        max-length = 10;
        tooltip = false;
        warning = 70;
        critical = 9;
    };

    temperature = {
        critical-threshold = 80;
        format = "{icon}&#8239;{temperatureC}°C";
        format-icons = ["" "" ""];
    };

    backlight = {
        format = "{icon}&#8239;{percent}%";
        format-icons = ["💡" "💡"];
        on-scroll-down = "brightnessctl -c backlight set 1%-";
        on-scroll-up = "brightnessctl -c backlight set +1%";
    };

    battery = {
        states = {
            good = 95;
            warning = 30;
            critical = 1;
        };

        format = "{icon}   {capacity}%";
        format-charging = "  {capacity}%";
        format-plugged = "  {capacity}%";
        format-alt = "{icon}  {time}";
        # "format-good": "", // An empty format will hide the module
        # "format-full": "",
        format-icons = ["" "" "" "" ""];
        # "format-icons": ["", "", "", "", ""]
    };

    network = {
        # "interface": "wlp2*", // (Optional) To force the use of this interface
        format-wifi = "   ({signalStrength}%)";
        format-ethernet = "&#8239;{ifname}: {ipaddr}/{cidr}";
        format-linked = "&#8239;{ifname} (No IP)";
        format-disconnected = "✈&#8239;Disconnected";
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        tooltip-format = "{essid}: {ipaddr}";
    };

    pulseaudio = {
      # "scroll-step": 1, // %, can be a float
      format = "{icon} {volume}%  {format_source}";
      format-bluetooth = "{icon} {volume}% {format_source}";
      format-bluetooth-muted = " {format_source}";
      format-muted = "  {format_source}";
      format-source = " {volume}%";
      format-source-muted = "";
      format-icons = {
        headphone = " ";
        hands-free = "";
        headset = "🎧";
        phone = " ";
        portable = " ";
        car = " ";
        default = ["" " " " "];
      };
      on-click = "pavucontrol";
    };
    
    "custom/spotify" = let
      # pythonWithDeps = pkgs.python3.withPackages (p: with p; [
      #   pygobject3
      # ]);
      # pythonWithDeps = "nix-shell -p 'python3.withPackages (python-pkgs: [python-pkgs.pygobject3])' -p playerctl -p gobject-introspection --command";
      pythonWithDeps = "nix-shell -p 'python3.withPackages (python-pkgs: [python-pkgs.pygobject3])' -p playerctl -p gobject-introspection --command";
      playerctl = "${pkgs.playerctl}/bin/playerctl";
      # script = toString (pkgs.writeShellScript "mediaplayer.py" ./scripts/mediaplayer.py);
      # script = pkgs.writeShellScriptBin "waybar-mediaplayer" ''
      # #!/usr/bin/env bash
      # export PATH=${pkgs.playerctl}/bin:${pkgs.gobject-introspection}:$PATH
      # ${pythonWithDeps}/bin/python3 ${./scripts/mediaplayer.py} --player spotify
      # '';
      # exec ${pythonWithDeps}/bin/python3 ${./scripts/mediaplayer.py} --player spotify
      # Provide Playerctl introspection and other dependencies like GLib
  # script = pkgs.buildFHSUserEnvBubblewrap {
  #   name = "mediaplayer-env";
  #   targetPkgs = pkgs: with pkgs; [
  #     playerctl   # Playerctl GObject library for media control
  #     gobject-introspection  # GObject introspection runtime
  #     python3
  #     python3Packages.pygobject3  # Python GObject introspection bindings
  #   ];
  #   profile = ''
  #     export GI_TYPELIB_PATH=${pkgs.playerctl}/lib/girepository-1.0:${pkgs.gobject-introspection}/lib/girepository-1.0
  #   '';
  #   script = pkgs.writeShellScriptBin "mediaplayer.py" ''
  #     #!/usr/bin/env bash
  #     exec ${pythonWithDeps}/bin/python3 ${./scripts/mediaplayer.py} --player spotify
  #   '';
      script = pkgs.writeShellScriptBin "mediaplayer-from-shell" ''
        #!/usr/bin/env bash
        python3 ${./scripts/mediaplayer.py} --player spotify
      '';
  # };
    in {
        # exec = "${pythonWithDeps}/bin/python3 ${script} --player spotify";
        # exec = "${script}";
        # exec = "${pythonWithDeps} ${script}";
        # exec = "${pythonWithDeps} python3 ${./scripts/mediaplayer.py} --player spotify";
        exec = "${pythonWithDeps} 'python ${./scripts/mediaplayer.py} --player spotify'";
        format = "{}  ";
        return-type = "json";
        on-click = "${playerctl} play-pause";
        on-scroll-up = "${playerctl} next";
        on-scroll-down = "${playerctl} previous";
    };

    "custom/recorder" = {
      format = "\uf03d Rec";
      format-disabled = "\uf03d Off-air";
      return-type = "json";
      interval = 1;
      exec = "echo '{\"class\": \"recording\"}'";
      exec-if = "pgrep wf-recorder";
    };

    "custom/audiorec" = {
      format = "♬ Rec";
      format-disabled = "♬ Off-air";
      return-type = "json";
      interval = 1;
      exec = "echo '{\"class\": \"audio recording\"}'";
      exec-if = "pgrep ffmpeg";
    };
    };
   }; 
  };
}
