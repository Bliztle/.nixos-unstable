{pkgs, ...}: {
  programs.nvf.settings.vim = {
    treesitter = {
      enable = true;
      context.enable = true;
      fold = false;
      grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        typescript
      ];
    };
    autocomplete.nvim-cmp = {
      enable = true;
      mappings = {
        next = "Down";
        previous = "Up";
      };
    };

    lsp = {
      enable = true;
      formatOnSave = true;
      lightbulb.enable = true;
      lspkind.enable = true;

      mappings = {
        # Actions
        codeAction = "<leader>ca";
        renameSymbol = "<leader>rn";
        # Goto
        goToDeclaration = "gD";
        goToDefinition = "gd";
        goToType = "gt";
        listImplementations = "gi";
        listReferences = "gr";
        # Diagnostics
        openDiagnosticFloat = "<leader>k";
        nextDiagnostic = "<leader>dn";
        previousDiagnostic = "<leader>dn";
        # Info
        hover = "K";
        signatureHelp = "<leader>K";
      };
    };

    keymaps = [
      {
        key = "<leader>hs";
        mode = "n";
        action = ":lua require('haskell-tools').hoogle.hoogle_signature()<CR>";
      }
      {
        key = "<leader>he";
        mode = "n";
        action = ":lua require('haskell-tools').lsp.buf_eval_all()<CR>";
      }
      {
        key = "<leader>hr";
        mode = "n";
        action = ":lua require('haskell-tools').repl.toggle()<CR>";
      }
    ];

    languages = {
      enableDAP = true;
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableLSP = true;
      enableTreesitter = true;

      # Languages
      bash.enable = true;
      css.enable = true;
      haskell.enable = true;
      helm.enable = true;
      html.enable = true;
      nix.enable = true;
      java.enable = true;
      python.enable = true;
      rust = {
        enable = true;
        crates.enable = true;
      };
      svelte.enable = true;
      tailwind.enable = true;
      ts = {
        enable = true;
        extensions.ts-error-translator.enable = true;
      };
      typst = {
        enable = true;
        format.enable = false;
      };
      yaml.enable = true;
    };
    extraPlugins = {
      emmet-vim.package = pkgs.vimPlugins.emmet-vim;
    };
  };
}
