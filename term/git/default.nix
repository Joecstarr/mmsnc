{ config, pkgs, ... }:
let
  username = config.myVars.git.username;
  email = config.myVars.git.email;
in
{
  home.packages = with pkgs; [
    delta
    difftastic
    ydiff
  ];

  programs.git = {
    enable = true;
    signing.format = "openpgp";
    ignores = [
      ".cache/"
      ".DS_Store"
      ".idea/"
      "*.swp"
      "*.elc"
      "auto-save-list"
      ".direnv/"
      "node_modules"
      "result"
      "result-*"
    ];
    settings = {
      user = {
        name = username;
        email = email;
      };

      column.ui = "auto";
      tag.sort = "version:refname";
      init.defaultBranch = "main";
      diff.algorithm = "histogram";
      diff.colorMoved = "plain";
      diff.mnemonicPrefix = true;
      diff.renames = true;
      push.default = "simple";
      push.autoSetupRemote = true;
      push.followTags = true;
      merge.tool = "nvim";
      mergetool.nvim.cmd = "nvim -d -c \"wincmd l\" -c \"norm ]c\" \"$LOCAL\" \"$MERGED\" \"$REMOTE\"";
      fetch.prune = true;
      fetch.pruneTags = true;
      fetch.all = true;
      help.autocorrect = "prompt";
      commit.verbose = true;
      rerere.enabled = true;
      rerere.autoupdate = true;
      color.ui = "1";
      color.branch = "auto";
      color.diff = "auto";
      color.interactive = "auto";
      color.status = "auto";
      pull.rebase = true;
      core.excludesfile = "~/.gitignore";
      rebase.autoSquash = true;
      rebase.autoStash = true;
      rebase.updateRefs = true;
      alias = {
        overwrite = "push --force-with-lease";
        undo = "reset HEAD~1 --mixed";
        branches = "branch -a";
        tags = "tag";
        stashes = "stash list";
        unstage = "reset -q HEAD --";
        discard = "checkout --";
        uncommit = "reset --mixed HEAD~";
        amend = "commit --amend";
        graph = "log --graph -10 --branches --remotes --tags  --";
        precommit = "diff --cached --diff-algorithm=minimal -w";
        unmerged = "diff --name-only --diff-filter=U";
        modified = "diff --name-only --diff-filter=M";
        deleted = "diff --name-only --diff-filter=D";
        remotes = "remote -v";
        lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
        lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
        # rofl = "!git log --first-parent --decorate --pretty=oneline --abbrev-commit | nl -v 0 | sed 's/\\([0-9].*$\\)/HEAD~\\1/' | tac";
        rofl = "!git --no-pager log --decorate --pretty=oneline --abbrev-commit --color=always | nl | tac";
        rmb = "!git fetch -p ; git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -D";
      };
    };
  };
}
