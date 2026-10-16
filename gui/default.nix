{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./batsignal
    ./hyprland
    ./wofi
    ./zathura
    ./xdg-portal.nix
    ./wayle
  ];
  home.packages = with pkgs; [
    chromium
    meld
    geeqie
    inkscape-with-extensions
    drawio
  ];
}
