# So best window tiling manager
{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
let
  user = config.myVars.username;
in
{
  home = {
    file."${config.home.homeDirectory}/.config/hypr/hyprland.lua" = {
      source = lib.mkForce ./conf/hyprland.lua;
    };

    file."${config.home.homeDirectory}/.config/hypr/animations.lua" = {
      source = lib.mkForce ./conf/animations.lua;
    };

    file."${config.home.homeDirectory}/.config/hypr/bindings.lua" = {
      source = lib.mkForce ./conf/bindings.lua;
    };

    file."${config.home.homeDirectory}/.config/hypr/apps.lua" = {
      source = lib.mkForce ./conf/apps.lua;
    };

    file."${config.home.homeDirectory}/.config/hypr/workspaces.lua" = {
      source = lib.mkForce ./conf/workspaces.lua;
    };

    packages = with pkgs; [
      qt5.qtwayland
      qt6.qtwayland
      libsForQt5.qt5ct
      qt6Packages.qt6ct
      hyprshot
      wayle
      hyprpicker
      swappy
      imv
      wf-recorder
      wlr-randr
      wl-clipboard
      brightnessctl
      gnome-themes-extra
      libva
      dconf
      wayland-utils
      wayland-protocols
      glib
      direnv
      meson
      hyprpaper
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
  };

  home.file."rootMirror/usr/share/wayland-sessions/hyprland.desktop" = {
    text = ''
      [Desktop Entry]
      Name=Hyprland
      Comment=An intelligent dynamic tiling Wayland compositor
      Exec=${pkgs.hyprland}/bin/start-hyprland
      Type=Application
      DesktopNames=Hyprland
      Keywords=tiling;wayland;compositor;
    '';
  };

  home.activation.setup-keyd-sytem-files = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    PATH="/usr/bin:/bin:$PATH"
    RM_PATH="/home/${user}/rootMirror"
    sudo mkdir -p /usr/share/wayland-sessions
    sudo ln -sf $RM_PATH/usr/share/wayland-sessions/hyprland.desktop /usr/share/wayland-sessions/hyprland.desktop
  '';

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
}
