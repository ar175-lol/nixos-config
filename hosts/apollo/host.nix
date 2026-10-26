{flakeRoot, ...}: {
  hosts.apollo = {
    enable = true;
    hostName = "apollo";
    stateVersion = "26.05";

    users = {
      ar175 = {
        description = "ar175";
        shell = "zsh";
        hashedPassword = "$6$4ObEABrHkyfFS35K$DkgMD.MLEY7N0FQehWWlJBvrFlmZS9kX3cNQ1L6Gok0VAsMFrRhdX1PoBgV7uC0NFzmzyZAQ2u6PW4jPSZV5M.";
        extraGroups = [
          "wheel"
          "video"
          "audio"
          "input"
          "adbusers"
        ];
        homeModules = [
          (flakeRoot + /homes/ar175/home.nix)
        ];
      };
      mom = {
        description = "mom";
        shell = "fish";
        hashedPassword = "$6$1yVg1hiI8fUALOA3$qx361OrYq6OuJFH/eHs6dIsqAU7FRPJc.VY0HkrDQiMj189Gw4U5RSmQ4P8a9A1CTcI3mEqblYmj17dD1GQdo/";
        extraGroups = [
          "video"
          "audio"
          "input"
        ];
        homeModules = [
          (flakeRoot + /homes/mom/home.nix)
        ];
      };
    };

    roles = [
      "graphical"
      "workstation"
      "laptop"
    ];

    features = {
      modules = {
        device = {
          hasSound = true;
          hasBluetooth = true;

          cpu.type = "intel";

          gpu = {
            intel.enable = true;
            nvidia = {
              enable = true;
              prime = {
                enable = true;
                intelBusId = "PCI:0:2:0";
                nvidiaBusId = "PCI:1:0:0";
              };
            };
          };
        };

        system = {
          programs.plasma.enable = true;
          loader.enable = true;
          fonts.enable = true;
          automount.enable = true;
        };

        profiles = {
          workstation.enable = true;
          gaming.enable = false;
        };
      };
    };

    extraModules = [./fs.nix];
  };
}
