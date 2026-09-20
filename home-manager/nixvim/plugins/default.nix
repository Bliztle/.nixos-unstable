{ ... }:
{
  imports = [
    ./telescope.nix
    ./llm.nix
    ./git.nix
    ./harpoon.nix
    ./neotest.nix
    ./notebook.nix
    ./render-latex.nix
    ./math-conceal.nix
    ./pdf.nix
  ];

  programs.nixvim = {
    plugins = {
      neo-tree = {
        enable = true;
        settings.filesystem.filtered_items.always_show = [
          ".nix"
          ".github"
          ".env"
          ".env.local"
          ".env.development.local"
          # Saga env
          ".env.schema"
          ".env.local-dev"
          ".env.local-dev.local"
        ];
      };
      nvim-autopairs.enable = true;
      trouble.enable = true;
      illuminate.enable = true;
      sleuth.enable = true;
      oil.enable = true;
      nvim-surround.enable = true;
      rainbow-delimiters.enable = true;
      highlight-colors.enable = true;
      nvim-lightbulb.enable = true;
      typst-preview.enable = true;
      lualine.enable = true;
      web-devicons.enable = true;
      rustaceanvim.enable = true;
      lean = {
        enable = true;
        settings.mappings = true;
      };
      # tailwind-tools.enable = true;
      markdown-preview.enable = true;
      render-markdown = {
        enable = true;
        settings = {
          latex.enabled = false;
          # Preserve render-latex's inline Unicode replacements (e.g. α and ×).
          win_options.conceallevel.rendered = 2;
          # Preserve render-latex's inline Unicode replacements (e.g. α and ×).
          file_types = [
            "markdown"
            "quarto"
          ];
          render_modes = [
            "n"
            "c"
            "t"
            "i"
            "v"
          ];
        };
      };
    };
  };
}
