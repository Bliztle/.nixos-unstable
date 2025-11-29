{
  programs.nvf.settings.vim.comments.comment-nvim = {
    enable = true;
    setupOpts = {
      pre_hook = "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";
    };
  };
}
