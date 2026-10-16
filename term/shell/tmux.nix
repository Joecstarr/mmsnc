# Tmux is a terminal multiplexer that allows you to run multiple terminal sessions in a single window.
{ pkgs, lib, ... }:
let
  Config = pkgs.writeShellScriptBin "Config" ''

  '';
in
{
  programs.tmux = {
    enable = true;
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";
    prefix = "C-g";
    terminal = "kitty";
    keyMode = "vi";

    extraConfig = lib.concatStringsSep "\n" [
      "bind u attach-session -t . -c '#{pane_current_path}'"
      # I think this helps with vim pasting
      "setw -g mode-keys vi"
      # vim needs this for auto read
      "set -g focus-events on"
      "set -gq allow-passthrough on"
      "set -g default-terminal 'tmux-256color'"
      "set -g visual-activity off"
      "set -g @plugin 'Mpdreamz/tmux-cmus'"
    ];

    plugins = with pkgs; [
      tmuxPlugins.resurrect
      tmuxPlugins.sensible
      tmuxPlugins.tokyo-night-tmux
    ];
  };
}
