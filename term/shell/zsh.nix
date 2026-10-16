# My shell configuration
{
  pkgs,
  lib,
  config,
  ...
}:
let
  user = config.myVars.username;
in
{

  home.packages = with pkgs; [
    bat
    btop
    ripgrep
    _7zz
    tldr
    sesh
    ripdrag
    ueberzugpp
    sniffnet
    kalker
    fd
    rip2

  ];
  # Set zsh as default shell on activation
  home.activation.make-zsh-default-shell = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # if zsh is not the current shell
      PATH="/usr/bin:/bin:$PATH"
      ZSH_PATH="/home/${user}/.nix-profile/bin/zsh"
      if [[ $(getent passwd ${user}) != *"$ZSH_PATH" ]]; then
        echo "setting zsh as default shell (using chsh). password might be necessay."
        if grep -q $ZSH_PATH /etc/shells; then
          echo "All good"
        else
          echo "adding zsh to /etc/shells"
          run echo "$ZSH_PATH" | sudo tee -a /etc/shells
        fi
        echo "running chsh to make zsh the default shell"
        run chsh -s $ZSH_PATH ${user}
        echo "zsh is now set as default shell !"
      fi
  '';
  home.sessionPath = [ "$HOME/go/bin" ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;

    initContent = lib.mkIf config.programs.tmux.enable ''
      function tat {
        
        name=$(basename `pwd` | sed -e 's/\.//g')

        if tmux ls 2>&1 | grep "$name: "; then
          true
        else
          tmux new-session -s "$name" -d
        fi
        tmux switch-client -t "$name" 2> /dev/null || tmux attach -t "$name"

        if tmux ls 2>&1 | grep "Useful_Tools: "; then
          true
        else
            tmux new-session -s Useful_Tools "cmus" -d
            tmux new-window -s Useful_Tools -n 2
            tmux send-keys -t Useful_Tools:2 "btop" C-m
        fi

      }    
    '';

    history = {
      save = 10000;
      size = 10000;
      share = true;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };

    profileExtra = lib.optionalString (config.home.sessionPath != [ ]) ''
      export PATH="$PATH''${PATH:+:}${lib.concatStringsSep ":" config.home.sessionPath}"
      setopt no_beep                                              # no beep
      setopt rm_star_wait                                             # wait 10 seconds before running `rm *`
      setopt hist_ignore_dups                                         # ignore history duplication
      setopt hist_expire_dups_first                                   # remove oldest duplicate commands from the history first
      setopt hist_ignore_space                                        # don't save commands beginning with spaces to history
      setopt append_history                                           # append to the end of the history file
      setopt inc_append_history                                       # always be saving history (not just when the shell exits)
      setopt no_flowcontrol                                          # Disable ^S and ^Q (freeze & resume flowcontro)
    '';

    #NOTE- for btop to show gpu usage
    #may want to check the driver version with:
    #nix path-info -r /run/current-system | grep nvidia-x11
    #and
    #nix search nixpkgs nvidia_x11
    sessionVariables = {
      LD_LIBRARY_PATH = lib.concatStringsSep ":" [
        "${pkgs.stdenv.cc.cc.lib}/lib"
        # "${pkgs.linuxPackages_latest.nvidia_x11_beta}/lib" # change the package name according to nix search result
        "$LD_LIBRARY_PATH"
      ];
      TERMCMD = "kitty --class=file_chooser";
      GTK_USE_PORTAL = "1";
    };

    shellAliases = {
      vim = "nvim";
      vi = "nvim";
      v = "nvim";
      c = "clear";
      clera = "clear";
      celar = "clear";
      e = "exit";
      cd = "z";
      prune = "git fetch --prune || git branch -vv | grep 'gone]' | awk '{print $1}' | xargs git branch -D";
      rm = "echo Use 'rip' instead of rm.";
      ls = "eza --icons=always --color=always --no-quotes";
      la = "eza --color=always -a";
      ll = "eza --color=always -alh";
      tree = "eza --icons=always --color=always --tree --no-quotes";
      sl = "ls";
      mv = "mv -b";
      open = "${pkgs.xdg-utils}/bin/xdg-open";
      icat = "${pkgs.kitty}/bin/kitty +kitten icat";
      ssh = "kitty +kitten ssh";
      cat = "bat --style=plain"; # cat alternative (bat)
      wireguard-import = "nmcli connection import type wireguard file";
      grep = "grep --color=auto";
      top = "btop";
      ip = "ip -color=auto";
      notes = "";
      note = "notes";
      mde = ''echo " use flake " >> .envrc && direnv allow'';
      # git
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      weather = "linecast weather";
      radar = "linecast radar";
      sunset = "linecast sunshine";
    };
  };
}
