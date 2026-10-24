{ inputs, pkgs, ... }:
let
  # Stable's Zotero 9 cannot read the existing Zotero 10 library. This snapshot
  # packages Zotero 10.0.4 with Firefox ESR 140 instead of the incompatible 153.
  # Remove this package set and the flake input once stable reaches 10.0.4.
  zoteroPkgs = import inputs.zotero-pinned {
    system = pkgs.stdenv.hostPlatform.system;
    config = {
      allowUnfree = true; # The bundled Mozilla Firefox binary.
      # ESR 140 is EOL; permit only this pinned compatibility runtime, only here.
      permittedInsecurePackages = [ "firefox-esr-140-bin-unwrapped-140.17.0esr" ];
    };
  };
in
{
  home.packages = [ zoteroPkgs.zotero ];
}
