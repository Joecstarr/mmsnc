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
    ./c.nix
    ./nix.nix
    ./py.nix
    ./json.nix
    ./toml.nix
    ./yaml.nix
    ./lua.nix
    ./typesetting
  ];
  home = {
    packages = with pkgs; [
    ];
  };
}
