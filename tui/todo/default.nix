{
  pkgs,
  config,
  inputs,
  ...
}:
{
  xdg.configFile =
    let
      mkSymlink = config.lib.file.mkOutOfStoreSymlink;
      confPath = "${config.home.homeDirectory}/server-cfg/home/programs/todo";
    in
    {
      "tuxedo/config.toml".source = mkSymlink "${confPath}/config.toml";
      "tuxedo/keybinds.toml".source = mkSymlink "${confPath}/keybinds.toml";
      "tuxedo/themes/dracula.toml".source = mkSymlink "${confPath}/themes/dracula.toml";
    };

  home.sessionVariables = {
    TODO_DIR = "$HOME/.todo";
  };

  home.packages = with pkgs; [
    tuxedo
  ];
}
