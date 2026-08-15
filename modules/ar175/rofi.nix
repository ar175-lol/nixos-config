{
  inputs,
  self,
  ...
}: let
  rasiLiteral = value: {
    _type = "literal";
    inherit value;
  };
in {
  perSystem = {pkgs, ...}: {
    packages.myRofi = inputs.wrapper-modules.wrappers.rofi.wrap {
      inherit pkgs;

      settings = {
        modes = ["drun" "window" "run"];
        show-icons = true;
        terminal = "foot";
        drun-display-format = "{icon} {name}";
        location = 0;
        disable-history = false;
        sidebar-mode = false;
        display-drun = "Launch: ";
        display-run = "Exec: ";

        "kb-row-up" = "Up,Control+k";
        "kb-row-left" = "Left,Control+h";
        "kb-row-right" = "Right,Control+l";
        "kb-row-down" = "Down,Control+j";
        "kb-accept-entry" = "Control+z,Control+y,Return,KP_Enter";
        "kb-remove-to-eol" = "";
        "kb-move-char-back" = "Control+b";
        "kb-remove-char-back" = "BackSpace";
        "kb-move-char-forward" = "Control+f";
        "kb-mode-complete" = "Control+o";
      };

      theme = {
        "@import" = "${placeholder "out"}/drun.rasi";

        "*" = {
          bg = rasiLiteral "#24283b";
          hv = rasiLiteral "#9274ca";
          primary = rasiLiteral "#C5C8C6";
          "border-color" = rasiLiteral "#9274ca";
          ug = rasiLiteral "#0B2447";
          font = "Monospace 11";
          "background-color" = rasiLiteral "@bg";
          border = rasiLiteral "0px";
          kl = rasiLiteral "#7aa2f7";
          black = rasiLiteral "#000000";
          transparent = rasiLiteral "rgba(46,52,64,0)";
        };

        window = {
          width = 700;
          orientation = rasiLiteral "horizontal";
          location = rasiLiteral "center";
          anchor = rasiLiteral "center";
          transparency = "screenshot";
          "border-color" = rasiLiteral "@transparent";
          border = rasiLiteral "0px";
          "border-radius" = rasiLiteral "6px";
          spacing = 0;
          children = [(rasiLiteral "mainbox")];
        };

        mainbox = {spacing = 0;};

        inputbar = {
          color = rasiLiteral "@kl";
          padding = rasiLiteral "11px";
          border = rasiLiteral "3px 3px 2px 3px";
          "border-color" = rasiLiteral "@border-color";
          "border-radius" = rasiLiteral "6px 6px 0px 0px";
        };

        message = {
          padding = 0;
          "border-color" = rasiLiteral "@primary";
          border = rasiLiteral "0px 1px 1px 1px";
        };

        "entry, prompt, case-indicator" = {
          "text-font" = rasiLiteral "inherit";
          "text-color" = rasiLiteral "inherit";
        };

        entry = {cursor = rasiLiteral "pointer";};
        prompt = {margin = rasiLiteral "0px 5px 0px 0px";};

        listview = {
          layout = rasiLiteral "vertical";
          padding = rasiLiteral "8px";
          lines = 7;
          columns = 2;
          border = rasiLiteral "0px 3px 3px 3px";
          "border-color" = rasiLiteral "@border-color";
          "border-radius" = rasiLiteral "0px 0px 6px 6px";
          dynamic = false;
        };

        element = {
          padding = rasiLiteral "2px";
          "vertical-align" = 1;
          color = rasiLiteral "@kl";
          font = rasiLiteral "inherit";
        };

        "element-text" = {
          "background-color" = rasiLiteral "inherit";
          "text-color" = rasiLiteral "inherit";
          "vertical-align" = rasiLiteral "0.5";
        };

        "element selected.normal" = {
          color = rasiLiteral "@black";
          "background-color" = rasiLiteral "@hv";
        };

        "element normal active" = {
          "background-color" = rasiLiteral "@hv";
          color = rasiLiteral "@black";
        };

        "element-icon" = {
          "background-color" = rasiLiteral "inherit";
          "text-color" = rasiLiteral "inherit";
          size = rasiLiteral "2.5em";
        };

        "element normal urgent" = {"background-color" = rasiLiteral "@primary";};

        "element selected active" = {
          background = rasiLiteral "@hv";
          foreground = rasiLiteral "@bg";
        };

        button = {
          padding = rasiLiteral "6px";
          color = rasiLiteral "@primary";
          "horizonatal-align" = rasiLiteral "0.5";
          border = rasiLiteral "2px 0px 2px 2px";
          "border-radius" = rasiLiteral "4px 0px 0px 4px";
          "border-color" = rasiLiteral "@primary";
        };

        "button selected normal" = {
          border = rasiLiteral "2px 0px 2px 2px";
          "border-color" = rasiLiteral "@primary";
        };
      };

      constructFiles."drun.rasi" = {
        content = "configuration {\n  drun {\n    DBusActivatable: false;\n  }\n}\n";
        relPath = "drun.rasi";
      };
    };
  };

  users.ar175.nixos.pc = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.myRofi];
  };

  users.ar175.home.gui = _: {
    xdg.desktopEntries = {
      rofi = {
        name = "Rofi";
        noDisplay = true;
      };
      "rofi-theme-selector" = {
        name = "Rofi Theme Selector";
        noDisplay = true;
      };
    };
  };
}
