_: {
  perSystem = {
    lib,
    pkgs,
    ...
  }: {
    myNiri.settings = {
      spawn-at-startup = [
        ["${lib.getExe pkgs.swaybg}" "-i" "${./../assets/wall1.jpg}"]
      ];

      prefer-no-csd = true;

      animations = {
        workspace-switch.spring = _: {
          props = {
            damping-ratio = 0.8;
            stiffness = 500;
            epsilon = 0.0001;
          };
        };
        window-movement.spring = _: {
          props = {
            damping-ratio = 0.8;
            stiffness = 500;
            epsilon = 0.0001;
          };
        };
        window-resize.spring = _: {
          props = {
            damping-ratio = 0.8;
            stiffness = 500;
            epsilon = 0.0001;
          };
        };
        overview-open-close.spring = _: {
          props = {
            damping-ratio = 0.8;
            stiffness = 500;
            epsilon = 0.0001;
          };
        };
        window-open = {
          duration-ms = 200;
          curve = "ease-out-expo";
        };
        window-close = {
          duration-ms = 150;
          curve = "ease-out-quad";
        };
      };

      input = {
        keyboard.xkb = {
          layout = "us,ru";
          options = "grp:alt_shift_toggle";
        };
        touchpad = {
          tap = _: {};
          natural-scroll = _: {};
        };
      };

      layout = {
        focus-ring = {
          width = 1;
          active-color = "#c6a0f6";
          inactive-color = "#494d64";
        };
        border = {
          width = 1;
          active-color = "#0DB7D455";
          inactive-color = "#31313600";
        };
        shadow = {
          on = _: {};
          softness = 30;
          spread = 3;
          offset = _: {
            props = {
              x = 0;
              y = 4;
            };
          };
          color = "#181926";
        };
        gaps = 9;
      };

      screenshot-path = null;
      gestures.hot-corners = {off = _: {};};

      cursor = {
        xcursor-theme = "Bibata-Modern-Classic";
        xcursor-size = 24;
        hide-when-typing = true;
      };

      window-rule = {
        clip-to-geometry = true;
        geometry-corner-radius = 12;
      };
      window-rules = [
        {
          matches = [{is-focused = false;}];
          shadow.off = _: {};
        }
      ];
    };
  };
}
