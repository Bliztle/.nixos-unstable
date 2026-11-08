{ ... }: {
  programs.nixvim = {
    keymaps = [
      {
        key = "<C-/>";
        mode = "n";
        action = "gcc";
        options = {
          remap = true;
          desc = "Toggle comment line";
        };
      }
      {
        # Traditional terminals encode Ctrl+/ as Ctrl+_.
        key = "<C-_>";
        mode = "n";
        action = "gcc";
        options = {
          remap = true;
          desc = "Toggle comment line";
        };
      }
      {
        key = "<C-/>";
        mode = "x";
        action = "gc";
        options = {
          remap = true;
          desc = "Toggle comments on selected lines";
        };
      }
      {
        # Traditional terminals encode Ctrl+/ as Ctrl+_.
        key = "<C-_>";
        mode = "x";
        action = "gc";
        options = {
          remap = true;
          desc = "Toggle comments on selected lines";
        };
      }
      {
        key = "s";
        mode = [ "n" "x" ];
        action.__raw = "function() require('flash').jump() end";
        options.desc = "Flash jump";
      }
      {
        # Keep visual S available for nvim-surround.
        key = "S";
        mode = "n";
        action.__raw = "function() require('flash').treesitter() end";
        options.desc = "Flash Treesitter selection";
      }
      {
        # Avoid nvim-surround's ys/ds/cs and yS/cS sequences.
        key = "z";
        mode = "o";
        action.__raw = "function() require('flash').jump() end";
        options.desc = "Flash jump";
      }
      {
        key = "Z";
        mode = "o";
        action.__raw = "function() require('flash').treesitter() end";
        options.desc = "Flash Treesitter selection";
      }
      {
        key = "r";
        mode = "o";
        action.__raw = "function() require('flash').remote() end";
        options.desc = "Flash remote action";
      }
      {
        key = "R";
        mode = [ "o" "x" ];
        action.__raw = "function() require('flash').treesitter_search() end";
        options.desc = "Flash Treesitter search";
      }
      {
        key = "j";
        mode = [ "n" "x" ];
        action = "v:count == 0 ? 'gj' : 'j'";
        options = {
          expr = true;
          silent = true;
          desc = "Down a visual line (buffer lines with a count)";
        };
      }
      {
        key = "k";
        mode = [ "n" "x" ];
        action = "v:count == 0 ? 'gk' : 'k'";
        options = {
          expr = true;
          silent = true;
          desc = "Up a visual line (buffer lines with a count)";
        };
      }
      {
        key = "<C-h>";
        mode = "n";
        action = "<C-w>h";
      }
      {
        key = "<C-j>";
        mode = "n";
        action = "<C-w>j";
      }
      {
        key = "<C-k>";
        mode = "n";
        action = "<C-w>k";
      }
      {
        key = "<C-l>";
        mode = "n";
        action = "<C-w>l";
      }
      {
        key = "<C-Left>";
        mode = "n";
        action = "<C-w>h";
      }
      {
        key = "<C-Down>";
        mode = "n";
        action = "<C-w>j";
      }
      {
        key = "<C-Up>";
        mode = "n";
        action = "<C-w>k";
      }
      {
        key = "<C-Right>";
        mode = "n";
        action = "<c-w>l";
      }
      # ZZ Jumps
      {
        key = "<C-d>";
        mode = "n";
        action = "<C-d>zz";
      }
      {
        key = "<C-u>";
        mode = "n";
        action = "<C-u>zz";
      }
      {
        key = "n";
        mode = "n";
        action = "nzzzv";
      }
      {
        key = "N";
        mode = "n";
        action = "Nzzzv";
      }
      {
        key = "gd";
        mode = "n";
        action = "gdzzzv";
      }
    ];
  };
}
