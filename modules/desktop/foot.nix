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
          font = "JetBrainsMono Nerd Font:size=12";
        };

        scrollback = {
          lines = 10000;
        };

        bell = {
          urgent = "no";
          notify = "no";
        };

        cursor = {
          style = "block";
          blink = "no";
        };

        "colors-dark" = {
          background = "1d2021";
          foreground = "ebdbb2";

          cursor = "282828 a89984";

          regular0 = "282828";
          regular1 = "cc241d";
          regular2 = "98971a";
          regular3 = "d79921";
          regular4 = "458588";
          regular5 = "b16286";
          regular6 = "689d6a";
          regular7 = "a89984";

          bright0 = "928374";
          bright1 = "fb4934";
          bright2 = "b8bb26";
          bright3 = "fabd2f";
          bright4 = "83a598";
          bright5 = "d3869b";
          bright6 = "8ec07c";
          bright7 = "ebdbb2";

          "selection-foreground" = "282828";
          "selection-background" = "ebdbb2";
        };
      };
    };
  };
}
