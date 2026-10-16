{
  config,
  pkgs,
  lib,
  inputs,
  nixGL,
  ...
}:
{
  imports = [
    ./config.nix
    ./services
    ./gui
    ./tui
    ./rice
    ./term
  ];

  programs.home-manager.enable = true;
  systemd.user.enable = true;

  xdg.enable = true;

  targets.genericLinux = {
    nixGL = {
      packages = nixGL.packages;
      defaultWrapper = "mesa";
      installScripts = [ "mesa" ];
    };
  };

  home = {
    inherit (config.myVars) username;
    homeDirectory = "/home/" + config.myVars.username;
    backupFileExtension = "backup";
    stateVersion = "26.05";
  };

}
