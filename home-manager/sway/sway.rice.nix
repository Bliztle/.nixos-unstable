{ ... }:
let
  theme = {
    foreground     = "0xffabb2bf";
    background     = "0xff282c34";
    selforeground  = "0xffd7a1e7";
    selbackground  = "0xff282c34";
    black          = "0xff282c34";
    magenta        = "0xffc678dd";
    blue           = "0xff61afef";
    yellow         = "0xffe5c07b";
    green          = "0xff98c379";
    red            = "0xffe06c75";
    cyan           = "0xff56b6c2";
  };
in
{
  wayland.windowManager.sway = {
    config = {
      window = {
        border = 3;
        titlebar = false;
        commands = [
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
        inner = 5;
        outer = 8;
      };

      colors = {
        focused = {
          border = "#61afef";
          background = "#e06c75";
        };
        unfocused = {
          border = "#282c34";
          background = "#282c34";
        };
      };
    };
  };
}
