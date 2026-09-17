{ pkgs, ... }:
let
  version = "0-unstable-2026-09-18";
  src = pkgs.fetchFromGitHub {
    owner = "pxwg";
    repo = "math-conceal.nvim";
    rev = "0c8dc9a63fe8f786333402e12c0b4ed3ae2ae5e1";
    hash = "sha256-vMSVb4rgtm9UxkFZkB+r+dudskuyWWsI07p07iDQrug=";
  };
  service = pkgs.rustPlatform.buildRustPackage {
    pname = "math-conceal-service";
    inherit version;
    src = "${src}/service";
    cargoLock.lockFile = "${src}/service/Cargo.lock";
    nativeBuildInputs = [ pkgs.pkg-config ];
    buildInputs = [ pkgs.openssl ];
  };
in
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        pname = "math-conceal.nvim";
        inherit version src;
      })
    ];
    extraConfigLua = ''
      require("math-conceal").setup({
        ft = { "typst" },
        integrations = { snacks = false },
        image = {
          enabled = true,
          renderers = {
            typst = {
              service_binary = "${service}/bin/typst-concealer-service",
            },
            markdown = { filetypes = {} },
          },
        },
      })
    '';
  };
}
