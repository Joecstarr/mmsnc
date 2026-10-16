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
      haskellPackages.nix-derivation # Analyse derivation with pretty-derivation < packagename.drv
      nix-diff # Check derivation differences
      nix-prefetch-github # Compute SHA256 github repository
      nix-tree
      nixfmt
      nvd
    ];
  };
}
