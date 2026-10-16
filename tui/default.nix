{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./lazygit
    ./todo
  ];
  home.packages = with pkgs; [
    bluetuith
    doxx
    linecast
    playball
    sabiql
    wifitui
    xleak
  ];
}
