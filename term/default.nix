{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./git
    ./kitty
    ./shell
    ./fetch
    ./nvim
    ./langtools
  ];
  home.packages = with pkgs; [
    #Misc tools
    curl
    dua
    duf
    fastmod
    magic-wormhole
    mprocs
    unzip
    wget
    just
    pcalc
    rclone
    quickemu
  ];
}
