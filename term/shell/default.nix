{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./eza.nix
    ./fzf.nix
    ./starship.nix
    ./tmux.nix
    ./yazi.nix
    ./zoxide.nix
    ./zsh.nix
    ./direnv.nix
  ];
  home.packages = with pkgs; [

  ];
}
