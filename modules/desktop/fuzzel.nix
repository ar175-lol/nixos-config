{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.myFuzzel = inputs.wrapper-modules.wrappers.fuzzel.wrap {
      inherit pkgs;

      settings = {
        main = {
          anchor = "center";
          font = "JetBrainsMono Nerd Font:size=12";
          dpi-aware = "no";
          terminal = "foot";

          y-margin = 16;
          width = 60;
          inner-pad = 16;
          horizontal-pad = 32;
          vertical-pad = 24;
          line-height = 32;
          lines = 10;
          prompt = "\"  \"";

          history = "~/.cache/fuzzel-history";
          sort-result = "yes";
        };

        border = {
          width = 1;
          radius = 24;
        };

        colors = {
          background = "24273af3";
          text = "cad3f5ff";
          border = "494d64ff";
          selection = "363956ff";
          selection-text = "cad3f5ff";
          selection-match = "8aadf4ff";
          prompt = "b7bdf8ff";
          input = "cad3f5ff";
          match = "8aadf4ff";
        };
      };
    };
  };
}
