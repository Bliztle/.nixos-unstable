{ pkgs, ... }:
let
  version = "0.1.0-rc4";
  src = pkgs.fetchFromGitHub {
    owner = "techwizrd";
    repo = "render-latex.nvim";
    tag = "v${version}";
    hash = "sha256-3aEYftSFKl9KxB6FVi65Fi063n7QRNawHejiISfci90=";
  };
  # Package the matching worker declaratively instead of downloading it in Neovim.
  worker = pkgs.stdenv.mkDerivation {
    pname = "render-latex-worker";
    inherit version;
    src = pkgs.fetchurl {
      url = "https://github.com/techwizrd/render-latex.nvim/releases/download/v${version}/render-latex-worker-linux-x64";
      hash = "sha256-j/BN4YQxuH4actxQwngGyJ3Ic6q/sPDYKdLOFoQDWvM=";
    };
    dontUnpack = true;
    nativeBuildInputs = [ pkgs.autoPatchelfHook ];
    buildInputs = [ pkgs.stdenv.cc.cc.lib ];
    installPhase = ''
      install -Dm755 "$src" "$out/bin/render-latex-worker"
    '';
    meta.platforms = [ "x86_64-linux" ];
  };
in
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        pname = "render-latex.nvim";
        inherit version src;
        # Upstream's automatic setup would otherwise reset our worker settings.
        postPatch = ''
          substituteInPlace plugin/render_latex.lua \
            --replace-fail 'require("render_latex").setup()' \
            'if not require("render_latex").did_setup then require("render_latex").setup() end'
        '';
      })
    ];
    extraConfigLua = ''
      require("render_latex").setup({
        worker = { bin = "${worker}/bin/render-latex-worker" },
        install = { auto = false },
      })
    '';
  };
}
