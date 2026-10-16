{
  inputs,
  outputs,
  nixos-wsl,
  agenix,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./tex.nix
    ./md.nix
    ./spelling.nix
  ];
  home = {
    packages = with pkgs; [
    ];
  };
}
