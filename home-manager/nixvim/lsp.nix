{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
        folding = false;
        grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
      };
      treesitter-context.enable = true;
      dap.enable = true;
      dap-ui.enable = true;
      lint.enable = true;
      luasnip.enable = true;
      # lsp-lines.enable = true;
      lsp-lines = {
        enable = true;
        luaConfig.content = "vim.diagnostic.config({ virtual_lines = true, virtual_text = false })";
      };
      lsp-format.enable = true;
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true; # Lua
          ts_ls.enable = true; # Typescript
          eslint.enable = true; # Eslint
          emmet_language_server.enable = true; # Emmet (div.class#id)
          tailwindcss.enable = true; # Tailwindcss
          html.enable = true; # HTML
          cssls.enable = true; # CSS
          tinymist.enable = true; # Typst
          hls = {
            enable = true; # Haskell
            installGhc = false;
          };
        };
        keymaps = {
          silent = true;
          lspBuf = {
            gd = {
              action = "definition";
              desc = "Goto Definition";
            };
            gr = {
              action = "references";
              desc = "Goto References";
            };
            gD = {
              action = "declaration";
              desc = "Goto Declaration";
            };
            gI = {
              action = "implementation";
              desc = "Goto Implementation";
            };
            gT = {
              action = "type_definition";
              desc = "Type Definition";
            };
            K = {
              action = "hover";
              desc = "Hover";
            };
            "<leader>rn" = {
              action = "rename";
              desc = "Rename Symbol";
            };
            "<leader>ca" = {
              action = "code_action";
              desc = "Code Action";
            };
            "<leader>f" = {
              action = "format";
              desc = "Format Document";
            };
          };
          diagnostic = {
            "<leader>df" = {
              action = "open_float";
              desc = "Line Diagnostics";
            };
            "<leader>dn" = {
              action = "goto_next";
              desc = "Next Diagnostic";
            };
            "<leader>dN" = {
              action = "goto_prev";
              desc = "Previous Diagnostic";
            };
          };
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          {
            name = "nvim_lsp";
          }
          {
            name = "luasnip";
          }
          {
            name = "path";
          }
          {
            name = "buffer";
          }
        ];
      };
    };
  };
}
