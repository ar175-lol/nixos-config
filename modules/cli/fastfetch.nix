_: {
  homeManager.ar175 = {
    programs.fastfetch = {
      enable = true;

      settings = {
        logo = {
          source = "nixos_small";
          padding = {
            right = 1;
          };
        };
        display = {
          size = {
            binaryPrefix = "si";
          };
          color = "blue";
          separator = ": ";
        };
        modules = [
          "os"
          "host"
          "kernel"
          "packages"
          "wm"
          "memory"
          "disk"
        ];
      };
    };
  };
}
