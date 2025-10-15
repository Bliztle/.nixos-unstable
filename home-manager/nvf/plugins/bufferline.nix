{...}: {
  programs.nvf.settings.vim.tabline.nvimBufferline = {
    enable = false;
    mappings = {
      closeCurrent = "<M-q>";
      cycleNext = "<M-l>";
      cyclePrevious = "<M-h>";
    };
  };
}
