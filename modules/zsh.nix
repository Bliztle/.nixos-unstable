{ pkgs, lib, config, ... }:

{
  # All configuration is done in program.zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting = {
      enable = true;
    };

    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
    };

    shellAliases = {
      c = "clear";
      g = "git";
      n = "nvim";
      p = "${pkgs.python3}/bin/python3";
      cat = "${pkgs.bat}/bin/bat";
      grep = "${pkgs.ripgrep}/bin/rg";
      find = "${pkgs.fd}/bin/fd";
      ls = "${pkgs.eza}/bin/eza";

      sgit = "sudo git -c \"include.path=\${XDG_CONFIG_DIR:-$HOME/.config}/git/config\" -c \"include.path=$HOME/.gitconfig\"";
      nshell = "nix-shell --command zsh -p";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd cd"
    ];
  };
}
