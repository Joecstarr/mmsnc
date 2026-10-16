{ lib, config, ... }:
with lib;
with types;
{
  options = {
    myVars = mkOption {
      type = attrs; # Should probably be `submodule, but I'm too lazy today
      description = "My config attrs";
    };
  };

  config.myVars = {
    username = "joe";
    keyboardLayout = "us";
    location = "Detroit";
    timeZone = "America/Detroit";
    defaultLocale = "en_US.UTF-8";
    git = {
      username = "Joe Starr";
      email = "joe@joe-starr.com";
    };
  };
}
