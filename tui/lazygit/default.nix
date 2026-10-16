{ config, lib, ... }:
let
  accent = "#${config.lib.stylix.colors.base0D}";
  muted = "#${config.lib.stylix.colors.base03}";
in
{
  programs.lazygit = {
    enable = true;
    settings = lib.mkForce {
      gui = {
        theme = {
          activeBorderColor = [
            accent
            "bold"
          ];
          inactiveBorderColor = [ muted ];
        };
        showListFooter = true;
        showRandomTip = false;
        showCommandLog = true;
        showBottomLine = true;
        nerdFontsVersion = "3";
        skipHookPrefix = "wip";
      };
    };
  };
}
