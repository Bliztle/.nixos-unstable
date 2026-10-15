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
        postPatch = ''
          # Keep commas between call arguments, including adjacent math formulas.
          substituteInPlace lua/math-conceal/symbols/typst/conceal_math.scm \
            --replace-fail '(#set! @punctuation.delimiter conceal " ")' \
            ""
          # Always show Typst equation boundaries, regardless of cursor position.
          substituteInPlace lua/math-conceal/symbols/typst/conceal_delim.scm \
            --replace-fail '(#set! @typ_inline_dollar conceal "")' \
            ""
          # Reveal all inline symbol replacements throughout the active multiline equation.
          substituteInPlace lua/math-conceal/render.lua \
            --replace-fail 'local function get_expand_range(spec, node)' \
            'local function get_expand_range(spec, node)
  if spec.target_lang == "typst" then
    local ancestor = node
    while ancestor do
      if ancestor:type() == "math" then
        local start_row, start_col, end_row, end_col = ancestor:range()
        if start_row < end_row then
          return start_row, start_col, end_row, end_col
        end
      end
      ancestor = ancestor:parent()
    end
  end'
          # Reveal every rendered expression intersecting the cursor line.
          substituteInPlace lua/math-conceal/image/placement/conflict.lua \
            --replace-fail 'return start_col ~= nil and cursor.col >= start_col and cursor.col < end_col' \
            'return start_col ~= nil'
        '';
      })
    ];
    extraConfigLua = ''
      require("math-conceal").setup({
        ft = { "typst" },
        -- Always show the full source on the cursor line, in every mode.
        opt = { concealcursor = "" },
        integrations = { snacks = false },
        image = {
          enabled = true,
          conceal_in_normal = false,
          live_preview_enabled = true,
          renderers = {
            typst = {
              service_binary = "${service}/bin/typst-concealer-service",
              code_render = { exclude = { "lorem", "smallcaps" } },
            },
            markdown = { filetypes = {} },
          },
        },
      })
    '';
  };
}
