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
  home = {
    packages = with pkgs; [
      rumdl
      marksman
    ];
  };
}
