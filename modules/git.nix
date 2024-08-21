{ pkgs, lib, config, ... }:

let
  cfg-path = ".config/git";
in
{
  options = {};
  config = {
    # Normal git configuration
    programs.git = {
      enable = true;
      userName = "Asbjørn Rysgaard Eriksen";
      userEmail = "mail@bliztle.com";
      delta.enable = true;

      # signing = {
      #   key = "654D56C64D41EAB7!";
      #   signByDefault = true;
      #   gpgPath = "${pkgs.gnupg}/bin/gpg";
      # };

      aliases = {
        a = "add";
        aa = "add -A";
        s = "status";
        sw = "switch";
        swc = "switch -c";
        swd = "!git switch `git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'`";
        st = "stash";
        stp = "stash pop";
        c = "commit -m";
        ca = "!git add -A && git commit -m";
        cam = "commit --amend";
        camp = "!git commit --amend && git push";
        campf = "!git commit --amend && git push --force-with-lease";
        camn = "commit --amend --no-edit";
        camnp = "!git commit --amend --no-edit && git push";
        camnpf = "!git commit --amend --no-edit && git push --force-with-lease";
        caam = "!git add -A && git commit --amend";
        caamp = "!git add -A && git commit --amend && git push";
        caampf = "!git add -A && git commit --amend && git push --force-with-lease";
        caamn = "!git add -A && git commit --amend --no-edit";
        caamnp = "!git add -A && git commit --amend --no-edit && git push";
        caamnpf = "!git add -A && git commit --amend --no-edit && git push --force-with-lease";
        co = "checkout";
        cob = "checkout -b";
        d = "diff";
        dh = "diff HEAD";
        dm = "diff main";
        do = "diff origin";
        doh = "diff origin/HEAD";
        dom = "diff origin/main";
        del = "branch -d";
        der = "!_gder() { git push origin --delete $1; }; _gder";
        delr = "!_gdelr() { git branch -d $1; git push origin --delete $1; }; _gdelr";
        p = "push";
        pb = "push --set-upstream origin HEAD";
        pf = "push --force-with-lease";
        r = "reset";
        ro = "reset origin/HEAD";
        rs = "reset --soft";
        rso = "reset --soft origin/HEAD";
        rh = "reset --hard";
        rho = "reset --hard origin/HEAD";
        # lg = "!git log --pretty=format:\"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]\" --abbrev-commit -30";
        lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
        lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
        lg = "lg1";

        sub = "submodule";
        sub-pull = "submodule foreach git pull";
        sub-add = "submodule add -b main"; # Call with <repo> [<path>]
      };

      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        pull = {
          rebase = "true";
        };
        core = {
          editor = "nvim";
        };
        pager = {
          branch = "false";
        };
        "remote \"origin\"" = {
          prune = "true";
        };
      };

      includes = [
        { 
          path = "~/${cfg-path}/caretaker.gitconfig";
          condition = "gitdir:~/work/caretaker/";
        }
      ];
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = false;
    };

    # Gitdir included configuration
    home.file."${cfg-path}/caretaker.gitconfig".text = ''
      [user]
        name = Asbjørn Rysgaard Eriksen
        email = are@caretaker.dk
    '';
  };
}
