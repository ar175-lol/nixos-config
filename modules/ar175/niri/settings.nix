_: {
  perSystem = {
    lib,
    self',
    pkgs,
    ...
  }: {
    myNiri.settings = {
      spawn-at-startup = [
        (lib.getExe self'.packages.myNoctalia)
      ];

      prefer-no-csd = true;

      animations = {
        workspace-switch.spring = _: {
          props = {
            damping-ratio = 1.0;
            stiffness = 700;
            epsilon = 0.0001;
          };
        };
        window-movement.spring = _: {
          props = {
            damping-ratio = 1.0;
            stiffness = 500;
            epsilon = 0.0001;
          };
        };
        window-resize.spring = _: {
          props = {
            damping-ratio = 0.8;
            stiffness = 400;
            epsilon = 0.0001;
          };
        };
        overview-open-close.spring = _: {
          props = {
            damping-ratio = 1.0;
            stiffness = 500;
            epsilon = 0.0001;
          };
        };
        window-open = {
          duration-ms = 220;
          curve = "ease-out-cubic";
        };
        window-close = {
          duration-ms = 180;
          curve = "ease-out-cubic";
        };
      };
      input = {
        keyboard = {
          xkb = {
            layout = "us,ru";
            options = "grp:alt_shift_toggle";
          };
          repeat-delay = 400;
          repeat-rate = 25;
        };
        touchpad = {
          tap = _: {};
          natural-scroll = _: {};
          dwt = _: {};
          click-method = "clickfinger";
          scroll-factor = 0.7;
        };
      };

      xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

      layout = {
        focus-ring = {
          width = 2;
          active-color = "#cba6f7";
          inactive-color = "#1e1e2e";
          urgent-color = "#f38ba8";
        };
        border = {
          width = 1;
          active-color = "#cba6f7";
          inactive-color = "#1e1e2e";
          urgent-color = "#f38ba8";
        };
        shadow = {
          on = _: {};
          color = "#11111b70";
        };
        tab-indicator = {
          active-color = "#cba6f7";
          inactive-color = "#6d10da";
          urgent-color = "#f38ba8";
        };
        insert-hint.color = "#cba6f780";
        gaps = 4;
        struts = {
          left = -1;
          right = -1;
          top = -1;
          bottom = -1;
        };
      };

      screenshot-path = null;
      gestures.hot-corners = {off = _: {};};

      cursor = {
        xcursor-theme = "Bibata-Modern-Classic";
        xcursor-size = 24;
        hide-when-typing = true;
      };

      window-rules = [
        {
          matches = [{app-id = "termfilechooser";}];
          open-floating = true;
        }
        {
          geometry-corner-radius = 18;
          clip-to-geometry = true;
          shadow = {
            on = _: {};
            softness = 30;
            spread = 5;
            color = "#00000080";
            offset = _: {
              props = {
                x = 0;
                y = 4;
              };
            };
          };
        }
      ];
    };
  };
}
