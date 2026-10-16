{...}: {
  imports = [
    ./plugins
    ./keymaps.nix
    ./lsp.nix
  ];
  programs.nixvim = {
    enable = true;
    nixpkgs.useGlobalPackages = true;
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };
    # colorschemes.tokyonight.enable = true;
    globals = {
      mapleader = " ";
    };
    opts = {
      number = true;
      relativenumber = true;
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      wrap = false;
      ignorecase = true;
      smarttab = true;
      smartcase = true;
      foldmethod = "expr";
      foldexpr = "nvim_treesitter#foldexpr()";
      foldenable = false;
    };
    autoCmd = [
      {
        event = "FileType";
        pattern = [ "markdown" "typst" ];
        callback.__raw = ''
          function()
            vim.opt_local.wrap = true
            vim.opt_local.linebreak = true
            vim.opt_local.breakindent = true
          end
        '';
      }
    ];
    clipboard.register = "unnamedplus";
  };
}
