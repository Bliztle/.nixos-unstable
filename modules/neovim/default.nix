{ pkgs, lib, ... }:

{
  options = {};
  config = {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;

      plugins = with pkgs.vimPlugins; [
          # General plugins
          nvim-treesitter
          nvim-treesitter.withAllGrammars # What is this dark magic?
          nvim-treesitter-context # Sticky functions
          auto-pairs
          nvim-ts-autotag
          nvim-surround # Surround with (ys | ds | cs){motion}{char}
          lualine-nvim
          telescope-nvim
          telescope-fzf-native-nvim
          cheatsheet-nvim # :Cheatsheet to pull up a list of keybinds
          neo-tree-nvim
          oil-nvim # Another file explorer which is handy for some bulk operations
          which-key-nvim
          vim-sleuth # Auto detect tabs
          clangd_extensions-nvim # c/c++ integration
          # copilot-vim
          comment-nvim # Comments based on treesitter's commentstring
          nvim-ts-context-commentstring # Comments for where file extension is not enough (jsx, svelte, etc.)
          markdown-preview-nvim
          bufferline-nvim # Display buffers in top statusline
          leap-nvim # Extra movement commands
          rainbow-delimiters-nvim # Rainbow brackets

          # Git integration
          vim-fugitive
          vim-rhubarb # Github integration for issues / :GBrowse
                      # Azure integration is not in the nixos store. See https://github.com/cedarbaum/fugitive-azure-devops.vim
          gitsigns-nvim # Line annotations

          # Language specific plugins
          haskell-tools-nvim

          # Color schemes
          catppuccin-nvim
          # vscode-nvim
          
          # Uni extensions
          # PDDL
          (pkgs.vimUtils.buildVimPlugin {
            pname = "pddl.vim";
            version = "latest";
            src = pkgs.fetchFromGitHub {
              owner = "PontusHanssen";
              repo = "pddl.vim";
              rev = "master";
              sha256 = "sha256-ph/LqZrV6trpATkTtibJgawBQo5jndPFpdU5pbuGfjg="; # Replace with the correct hash
            };
          })


          # Libs
          nui-nvim # nvim ui components used by neo-tree-nvim
          plenary-nvim # nvim lua library used by telescope and neo-tree-nvim
          nvim-web-devicons # Icons for neo-tree-vim and lualine-nvim

          # Lsp and completion
          nvim-lspconfig
          luasnip # Snippet framework
          nvim-cmp # Auto complete
          cmp-nvim-lsp # Get completions from lsp
          cmp-buffer # Get completions from buffer
          cmp_luasnip # Get completions from snippets
          lspkind-nvim # VSCode-like icons on completions
          nvim-dap # Debugger
          nvim-dap-ui # UI for Debugger
          vim-prettier # Prettier integration
      ];

      extraPackages = with pkgs; [
      	gcc # Supposedly needed for treesitter

        # Language Servers
        # C#
        omnisharp-roslyn
        # Haskell
        # haskell-language-server
        # haskellPackages.hoogle # Haskell documentation
        # JS / TS
        vscode-langservers-extracted
        nodePackages_latest.typescript-language-server
        tailwindcss-language-server # Tailwind CSS
        emmet-language-server # Emmet, HTML/CSS abbreviations like div.container>div.row>div.col#id*2
        # Lua
        lua-language-server
        # Nix
        nil
        # OCaml
        ocamlPackages.ocaml-lsp
        ocamlPackages.ocamlformat
        # Python
        pyright
      ];

      extraLuaConfig = builtins.concatStringsSep "\n" ((map lib.strings.fileContents (import ./lua)) ++ []);
    };
  };
}
