{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.myFoot = inputs.wrapper-modules.wrappers.foot.wrap {
      inherit pkgs;
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font:size=12.4";
          pad = "0x0 center color=222436";
        };
        scrollback.lines = 10000;
        bell = {
          urgent = "no";
          notify = "no";
        };
        cursor = {
          style = "beam";
          blink = "yes";
        };
        colors-dark = {
          background = "222436";
          foreground = "c0caf5";
          cursor = "ead6d4 f5e0dc";
          regular0 = "1b1d2b";
          regular1 = "f7768e";
          regular2 = "c3e88d";
          regular3 = "ffc777";
          regular4 = "7aa2f7";
          regular5 = "c099ff";
          regular6 = "4fd6be";
          regular7 = "c8d3f5";
          bright0 = "444a73";
          bright1 = "f7768e";
          bright2 = "c3e88d";
          bright3 = "ffc777";
          bright4 = "7aa2f7";
          bright5 = "c099ff";
          bright6 = "4fd6be";
          bright7 = "c8d3f5";
          selection-foreground = "c0caf5";
          selection-background = "2d3f76";
        };
      };
    };
  };
}
