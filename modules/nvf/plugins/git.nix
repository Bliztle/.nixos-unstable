{...}: {
  programs.nvf.settings.vim.git = {
    enable = true;
    gitsigns = {
      enable = true;
      mappings = {
        previewHunk = "ghd";
        nextHunk = "ghn";
        previousHunk = "ghN";
        resetHunk = "ghr";
        stageHunk = "ghs";
      };
      setupOpts = {
        current_line_blame = true;
        word_diff = true;
      };
    };
  };
}
