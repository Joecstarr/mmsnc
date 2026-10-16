{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./dracula.nix
    ./fonts.nix
  ];
}
