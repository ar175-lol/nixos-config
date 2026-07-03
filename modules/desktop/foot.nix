{
  self,
  inputs,
  ...
}: {
  nixos.desktop = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myFoot
    ];
  };

  perSystem = {pkgs, ...}: {
    packages.myFoot = inputs.wrapper-modules.wrappers.foot.wrap {
      inherit pkgs;

      settings = {
        main = {
          font = "JetBrainsMono NF:size=12";
        };
        scrollback = {
          lines = 10000;
        };

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

          cursor = "1e1e2e f5e0dc";

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

          selection-foreground = "11111b";
          selection-background = "f5e0dc";
        };
      };
    };
  };
}
