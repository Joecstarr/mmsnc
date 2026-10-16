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
  ];
  home = {
    packages = with pkgs; [
      stdenv.cc.cc.lib
      hextazy
    ];
  };
}
