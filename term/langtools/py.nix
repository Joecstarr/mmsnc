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
      ty
      uv
      ruff
    ];
  };
}
