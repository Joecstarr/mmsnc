{ pkgs, inputs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    roboto
    work-sans
    comic-neue
    source-sans
    comfortaa
    inter
    lato
    lexend
    jost
    liberation_ttf
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.fira-code
    nerd-fonts.meslo-lg
    openmoji-color
    twemoji-color-font
    google-fonts
    inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro-nerd
  ];
}
