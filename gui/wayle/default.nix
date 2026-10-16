# Wofi is a launcher for Wayland, inspired by rofi.
{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.wayle = {
    enable = true;

    # Whether to automatically install soft dependencies used by wayle that
    # will be required based on your config.
    autoInstallDependencies = true;

    # tip: you can automatically translate your TOML config to Nix by running
    # nix-instantiate --eval --expr 'builtins.fromTOML (builtins.readFile ./config.toml)' | nixfmt
    settings = {
      bar = {
        scale = 0.65;
        bg = "transparent";
        button-variant = "basic";
        button-opacity = 73;
        button-bg-opacity = 0;
        button-gap = 0.5;
        layout = [
          # add more attribute sets with different monitors if wayle should
          # have different layouts on each
          {
            monitor = "*"; # replace "DP-1" with "*" for all monitors
            show = true;
            center = [
              "clock"
              "weather"
            ];
            left = [
              "dashboard"
              "hyprland-workspaces"
            ];
            right = [
              "hyprsunset"
              "idle-inhibit"
              "volume"
              "battery"
              "notifications"
            ];
          } # this is a 'list' of 'attribute sets', no semi-colons after the closing braces needed
        ];
      };
      wallpaper.engine-enabled = false;
      modules = {
        clock = {
          format = "%H:%M:%S";
          dropdown-show-seconds = false;
        };
        weather = {
          location = "Detroit";
          units = "imperial";
        };
        hyprland-workspaces = {
          min-workspace-count = 4;
          show-special = false;
          display-mode = "icon";
        };
        hyprsunset = {
          temperature = 2500;
        };
      };
    };
  };
}
