# yazi
{ pkgs, ... }:
let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "68f7d48";
    hash = "sha256-6iA/C0dzbLPkEDbdEs8oAnVfG6W+L8/dYyjTuO5euOw=";
  };
in
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    keymap = {
      manager.prepend_keymap = [
        {
          on = [ "d" ];
          run = ''shell 'rip "$@"' '';
        }
        {
          run = ''shell 'ripdrag "$@" -x 2>/dev/null &' --confirm'';
          on = [ "<C-D>" ];
        }
        {
          run = "plugin mount";
          on = [ "M" ];
        }
        {
          on = [ "c" ];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }
      ];
    };
    settings = {
      manager = {
        show_hidden = true;
      };
      preview = {
        max_width = 1000;
        max_height = 1000;
      };

      opener = {
        play = [
          {
            run = "vlc \"$@\"";
            orphan = true;
            for = "linux";
          }
        ];
        edit = [
          {
            run = "$EDITOR \"$@\"";
            orphan = true;
            for = "linux";
          }
        ];
        pdf = [
          {
            run = "zathura \"$@\"";
            orphan = true;
            for = "linux";
          }
        ];
        brwsr = [
          {
            run = "zen \"$@\"";
            orphan = true;
            for = "linux";
          }
        ];
        img = [
          {
            run = "imv \"$@\"";
            orphan = true;
            for = "linux";
          }
        ];
        open = [
          {
            run = "xdg-open \"$@\"";
            desc = "Open";
          }
        ];
      };

      open.rules = [
        {
          mime = "application/json";
          use = "edit";
        }
        {
          mime = "text/markdown";
          use = "edit";
        }
        {
          mime = "text/plain";
          use = "edit";
        }
        {
          mime = "text/x-shellscript";
          use = "edit";
        }
        {
          mime = "text/x-python";
          use = "edit";
        }
        {
          mime = "text/x-go";
          use = "edit";
        }
        {
          mime = "text/css";
          use = "edit";
        }
        {
          mime = "text/javascript";
          use = "edit";
        }
        {
          mime = "text/x-c";
          use = "edit";
        }
        {
          mime = "text/x-c++";
          use = "edit";
        }
        {
          mime = "text/x-java";
          use = "edit";
        }
        {
          mime = "text/x-rust";
          use = "edit";
        }
        {
          mime = "text/x-yaml";
          use = "edit";
        }
        {
          mime = "text/x-toml";
          use = "edit";
        }
        {
          mime = "text/x-dockerfile";
          use = "edit";
        }
        {
          mime = "text/x-xml";
          use = "edit";
        }
        {
          mime = "text/x-php";
          use = "edit";
        }
        {
          mime = "image/png";
          use = "img";
        }
        {
          mime = "image/jpeg";
          use = "img";
        }
        {
          mime = "image/jpg";
          use = "img";
        }
        {
          mime = "image/webp";
          use = "img";
        }
        {
          mime = "image/gif";
          use = "brwsr";
        }
        {
          mime = "x-scheme-handler/http";
          use = "brwsr";
        }
        {
          mime = "x-scheme-handler/https";
          use = "brwsr";
        }
        {
          mime = "text/html";
          use = "brwsr";
        }
        {
          mime = "application/pdf";
          use = "pdf";
        }
        {
          mime = "x-scheme-handler/chrome";
          use = "brwsr";
        }
        {
          mime = "application/x-extension-htm";
          use = "brwsr";
        }
        {
          mime = "application/x-extension-html";
          use = "brwsr";
        }
        {
          mime = "application/x-extension-shtml";
          use = "brwsr";
        }
        {
          mime = "application/xhtml+xml";
          use = "brwsr";
        }
        {
          mime = "application/x-extension-xhtml";
          use = "brwsr";
        }
        {
          mime = "application/x-extension-xht";
          use = "brwsr";
        }

      ];
      fetchers = [
        {
          id = "git";
          name = "*";
          run = "git";
        }

        {
          id = "git";
          name = "*/";
          run = "git";
        }
        {
          id = "mime";
          name = "*";
          run = "mime-ext";
          prio = "high";
        }
      ];
    };

    plugins = {
      chmod = "${yazi-plugins}/chmod.yazi";
      mount = "${yazi-plugins}/mount.yazi";
      mime-ext = "${yazi-plugins}/mime-ext.yazi";
      git = "${yazi-plugins}/git.yazi";
      full-border = "${yazi-plugins}/full-border.yazi";
      max-preview = "${yazi-plugins}/max-preview.yazi";
      starship = pkgs.fetchFromGitHub {
        owner = "Rolv-Apneseth";
        repo = "starship.yazi";
        rev = "c070754";
        sha256 = "sha256-H8j+9jcdcpPFXVO/XQZL3zq1l5f/WiOm4YUxAMduSRs=";
      };
    };

    initLua = ''
      require("starship"):setup()
      require("git"):setup()
      require("full-border"):setup()
    '';
  };
  xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
    force = true;
    text = ''
      [filechooser]
      cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    '';
  };
}
