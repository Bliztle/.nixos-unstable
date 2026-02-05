{ pkgs, ... }:
{
  imports = [
    ./starship.nix
  ];

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
      # ls = "${pkgs.eza}/bin/eza";
      nshell = "nix-shell --command zsh -p";
    };
  };

  home.shellAliases = {
    c = "clear";
    g = "git";
    n = "nvim";
    k = "kubectl";
    p = "${pkgs.python3}/bin/python3";
    cat = "${pkgs.bat}/bin/bat";
    grep = "${pkgs.ripgrep}/bin/rg";
    find = "${pkgs.fd}/bin/fd";

    sgit = "sudo git -c \"include.path=\${XDG_CONFIG_DIR:-$HOME/.config}/git/config\" -c \"include.path=$HOME/.gitconfig\"";
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  home.shell.enableNushellIntegration = true;
  programs.nushell = {
    enable = true;
    plugins = with pkgs.nushellPlugins; [
      query
      # highlight
    ];
    settings = {
      buffer_editor = "nvim";
      edit_mode = "vi";
      show_banner = false;
    };
    shellAliases = {
      fg = "job unfreeze";
      nshell = "nix-shell --command nu -p";
    };
    extraConfig = ''
      def nix-init [] {
        nix flake init --template templates#utils-generic
        direnv allow
      }
    '';
    envFile.text = ''
      $env.PATH ++= ['~/.config/scripts']
      $env.EDITOR = 'nvim'
      source-env ~/.config/nushell/env.secret.nu
    '';
  };

  # enable carapace for shell completions
  programs.carapace.enable = true;
}
