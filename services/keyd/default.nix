{
  inputs,
  config,
  agenix,
  pkgs,
  lib,
  ...
}:
let
  user = config.myVars.username;
in
{
  home = {

    packages = with pkgs; [
      keyd
    ];

    file."/rootMirror/env/etc/libinput/local-overrides.quirks" = {
      text = ''
        [Serial Keyboards]
        MatchUdevType=keyboard
        MatchName=keyd virtual keyboard
        AttrKeyboardIntegration=internal
      '';
    };

    file."/rootMirror/etc/keyd/default.conf" = {
      source = ./default.conf;
    };

    file."/rootMirror/etc/systemd/system/keyd.service" = {
      text = ''
        [Unit]
        Description=Keyd Service
        After=network.target
         
        [Service]
        Type=simple
        ExecStart=${pkgs.keyd}/bin/keyd
        Restart=always
         
        [Install]
        WantedBy=multi-user.target
      '';
    };

    activation.setup-keyd-sytem-files = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      PATH="/usr/bin:/bin:$PATH"
      RM_PATH="/home/${user}/rootMirror"
      sudo mkdir -p /etc/systemd/system/
      sudo ln -sf $RM_PATH/etc/systemd/system/keyd.service /etc/systemd/system/keyd.service
      sudo mkdir -p /etc/keyd
      sudo ln -sf $RM_PATH/etc/keyd/default.conf /etc/keyd/default.conf
      sudo mkdir -p /env/etc/libinput/
      sudo ln -sf $RM_PATH/env/etc/libinput/local-overrides.quirks /env/etc/libinput/local-overrides.quirks
      sudo systemctl daemon-reload
      sudo systemctl enable keyd.service
      sudo systemctl start keyd.service
    '';

  };
}
