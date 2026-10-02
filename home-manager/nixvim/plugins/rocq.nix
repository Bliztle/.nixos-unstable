{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      (Coqtail.overrideAttrs (old: {
        # Coqtail 1.10 warns when its Python backend is disabled, even when
        # only its syntax, indentation and text objects are wanted for LSP.
        postPatch = (old.postPatch or "") + ''
          substituteInPlace ftplugin/coq.vim \
            --replace-fail 'if !g:coqtail_supported' 'if 0'
        '';
      }))
      coq-lsp-nvim
    ];

    # Use Coqtail's filetype support without starting a second proof backend.
    globals = {
      loaded_coqtail = 1;
      coqtail_supported = 0;
    };

    extraConfigLua = ''
      -- This plugin owns LSP registration and the proof-goal protocol handlers.
      -- Do not also enable plugins.lsp.servers.coq_lsp.
      require('coq-lsp').setup({
        coq_lsp_nvim = {
          info_panel_mode = 'tab',
          info_panel_sticky_close = true,
        },
        lsp = {
          -- Resolve through PATH so a project's nix develop environment can
          -- supply its own matching compiler, libraries and language server.
          cmd = { 'coq-lsp' },
          root_markers = { '_RocqProject', '_CoqProject', 'dune-project', '.git' },
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
          on_attach = function(_, bufnr)
            local function map(lhs, rhs, desc)
              vim.keymap.set('n', lhs, rhs, {
                buffer = bufnr,
                silent = true,
                desc = desc,
              })
            end
            map('<leader>rp', '<Cmd>CoqLsp open_info_panel<CR>', 'Rocq: open proof goals')
            map('<leader>rv', '<Cmd>CoqLsp saveVo<CR>', 'Rocq: save checked .vo file')
            map('<leader>rr', '<Cmd>LspRestart coq_lsp<CR>', 'Rocq: restart language server')
          end,
        },
      })
    '';
  };
}
