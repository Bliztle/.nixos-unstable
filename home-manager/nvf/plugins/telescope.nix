{...}: {
  programs.nvf.settings.vim = {
    telescope = {
      enable = true;
      setupOpts.defaults.file_ignore_patterns = [
        "node_modules"
        "%.git/"
        "dist/"
        "build/"
        "target/"
        "result/"
        "%.svelte%-kit/"
        ".direnv"
      ];
    };
  };
}
