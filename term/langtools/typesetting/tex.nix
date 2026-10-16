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
      svg2pdf
      pstoedit
      texliveFull
      tex-fmt
      ghostscript
      poppler-utils
      optipng
      fig2dev
      imagemagick
      gnumake
      ltex-ls-plus
      cairo
    ];
  };
}
