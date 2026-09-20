{ pkgs, ... }:
let
  version = "0-unstable-2026-09-18";

  pdfreader = pkgs.vimUtils.buildVimPlugin {
    pname = "pdfreader.nvim";
    inherit version;

    src = pkgs.fetchFromGitHub {
      owner = "r-pletnev";
      repo = "pdfreader.nvim";
      rev = "f8c067648b0c0d332a8d241111787a6b4d7ba061";
      hash = "sha256-kvedUdaDvdJkfD7cG1AaezYWEeq9WNyui0EjBu/SrRQ=";
    };

    dependencies = with pkgs.vimPlugins; [
      snacks-nvim
      telescope-nvim
      plenary-nvim
    ];

    doCheck = false;
    nvimRequireCheck = false;
  };
in
{
  home.packages = with pkgs; [
    imagemagick
    ghostscript
    poppler-utils
  ];

  programs.nixvim = {
    extraPlugins = [
      pdfreader
    ];

    extraConfigLua = ''
      require("snacks").setup({
        image = {
          enabled = true,
          formats = {
            "png",
            "jpg",
            "jpeg",
            "gif",
            "bmp",
            "webp",
            "tiff",
            "heic",
            "avif",
            "icns",
          },
          math = { enabled = false },
        },
      })

      require("pdfreader").setup()
    '';
  };
}
