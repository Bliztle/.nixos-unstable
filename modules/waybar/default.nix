{
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainbar = {
        layer = "top";
        position = "top";

        # modules-left = [ "custom/left" "hyprland/workspaces" "custom/right" "custom/left" "sway/workspaces" "sway/mode" "temperature" "cpu" "memory" "disk" "custom/right" ];
        # modules-center = [ "custom/left" "custom/music" "custom/right" ];
        # modules-right = [ "custom/left" "tray" "custom/right" "custom/left" "backlight" "pulseaudio" "network" "battery" "clock" "custom/right" ];

        modules-left = [ "hyprland/workspaces" "sway/workspaces" "sway/mode" "temperature" "cpu" "memory" "disk" "tray" "backlight" "pulseaudio" "network" "custom/expressvpn" "battery" "clock" "custom/music" ];
        # modules-center = [ "custom/music" ];
        # modules-right = [ "tray" "backlight" "pulseaudio" "network" "custom/expressvpn" "battery" "clock" ];

        "hyprland/workspaces" = {
          # active-only = false;
          # all-outputs = true;
          all-outputs = false;
          # show-special = true;
          format = "{icon}";
          format-icons = {
            active = "&#10052;";
            persistent = "";
            empty = "";
            urgent = "";
            default = "&#10052;";
          };
          # persistent-workspaces = {
          #   "*" = 5;
          # };
        };

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

        tray = {
          icon-size = 18;
          spacing = 10;
        };

        temperature = {
          critical-threshold = 80;
          format-critical = "{icon} {temperatureC}°";
          format = "{icon} {temperatureC}°";
          format-icons = [ "󱃃" "󱩿" "󰸁" ];
        };

        cpu.format = "󰻠 {usage}%";
        memory.format = "󰍛 {}%";

        network = {
            # "interface": "wlp2*", // (Optional) To force the use of this interface
            format-wifi = "   ({signalStrength}%)";
            format-ethernet = "&#8239;{ifname}: {ipaddr}/{cidr}";
            format-linked = "&#8239;{ifname} (No IP)";
            format-disconnected = "✈&#8239;Disconnected";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
            tooltip-format = "{essid}: {ipaddr}";
        };

        # network = {
        #   format-wifi = "󰘊 {signalStrength}%";
        #   format-ethernet = "󰈀";
        #   tooltip-format = "󰈀 {ifname} via {gwaddr}";
        #   format-disconnected = "󰞃 Disconnected";
        # };

        # "custom/pacman" = {
        #   format = "{}  ";
        #   interval = 1800;
        #   exec = "checkupdates | wc -l";
        #   exec-if = "exit 0";
        # };

        backlight = {
          format = "{icon}&#8239;{percent}%";
          format-icons = [ "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨" ];
          on-scroll-down = "brightnessctl -c backlight set 1%-";
          on-scroll-up = "brightnessctl -c backlight set +1%";
        };

        disk = {
          interval = 30;
          format = "󱛟 {used}";
          unit = "GB";
          path = "/";
        };

        "custom/left" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };

        "custom/right" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };

        "custom/music" = {
          format = "  {}";
          escape = true;
          interval = 5;
          tooltip = false;
          exec = "playerctl metadata --format='{{ title }}'";
          on-click = "playerctl play-pause";
          max-length = 40;
        };

        "custom/expressvpn" = {
          format = "󰒃 {}";
          interval = 10;
          exec = "waybar-expressvpn-status";
        };

        clock = {
          tooltip = false;
          timezone = "Europe/Copenhagen";
          format = "󰥔 {:%H:%M | %d/%m}";
        };

        battery = {
          tooltip = false;
          full-at = 98;
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󱐋 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-alt = "{icon}  {time}";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
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

        # wireplumber = {
        #   tooltip = false;
        #   format = "{icon} {volume}%";
        #   format-muted = "";
        #   max-volume = 120;
        #   format-icons = [ "" "" "" ];
        # };

        # "custom/scrot" = {
        #   tooltip = false;
        #   on-click = "";
        #   format = "";
        # };
      };
    };
  };
}
