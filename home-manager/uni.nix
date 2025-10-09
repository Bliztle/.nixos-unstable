{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (pkgs.postgresql18Packages.postgis.overrideAttrs (
      final: prev: {
        configureFlags = prev.configureFlags ++ [ "--with-gui" ];
        buildInputs = prev.buildInputs ++ [ pkgs.gtk2 ];
      }
    ))
  ];
}
