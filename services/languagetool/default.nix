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
      languagetool
      jre
    ];
  };

  systemd.user.services.languagetool = {
    Unit = {
      Description = "languagetool daemon";
      After = [
        "network.target"
      ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = ''
        ${lib.getExe pkgs.jre} \
          -cp ${pkgs.languagetool}/share/languagetool-server.jar \
          -Xmx512m \
          org.languagetool.server.HTTPServer \
          --port 8081 \
          --allow-origin * 
      '';
    };
  };
}
