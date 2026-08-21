{
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    ...
  }: {
    packages.myTerminal = inputs.wrapper-modules.wrappers.foot.wrap {
      inherit pkgs;
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font:size=12.4";
          pad = "0x0 center color=1e1e2e";
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
          background = "1e1e2e";
          foreground = "cdd6f4";
          regular0 = "45475a";
          regular1 = "f38ba8";
          regular2 = "a6e3a1";
          regular3 = "f9e2af";
          regular4 = "89b4fa";
          regular5 = "f5c2e7";
          regular6 = "94e2d5";
          regular7 = "bac2de";
          bright0 = "585b70";
          bright1 = "f38ba8";
          bright2 = "a6e3a1";
          bright3 = "f9e2af";
          bright4 = "89b4fa";
          bright5 = "f5c2e7";
          bright6 = "94e2d5";
          bright7 = "a6adc8";
        };
      };
    };
  };
}
