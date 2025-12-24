{...}: {
  imports = [
    ./keymaps.nix
    ./lsp.nix
    ./plugins
  ];

  programs.nvf = {
    enable = false;
    enableManpages = true;
    settings.vim = {
      options = {
        tabstop = 4;
        softtabstop = 4;
        shiftwidth = 4;
        expandtab = true;
        wrap = false;
      };
      searchCase = "smart";
      theme.enable = true;
      theme.name = "catppuccin";
      theme.style = "mocha";
      clipboard = {
        enable = true;
        registers = "unnamedplus";
      };
    };
  };
}
