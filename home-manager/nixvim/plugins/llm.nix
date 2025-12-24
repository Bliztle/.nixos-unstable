{...}: {
  programs.nixvim = {
    plugins = {
      copilot-lua = {
        enable = false;
        settings = {
          panel.enabled = false;
          suggestion = {
            auto_trigger = true;
            keymap = {
              accept = "<C-CR>";
            };
          };
        };
      };
      avante = {
        enable = true;
        settings = {
          provider = "copilot";
        };
      };
    };
  };
}
