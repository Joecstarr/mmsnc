{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    # ./keyd
    ./languagetool
  ];

}
