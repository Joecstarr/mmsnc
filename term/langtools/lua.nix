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
      lua-language-server
      stylua
    ];
  };
}
