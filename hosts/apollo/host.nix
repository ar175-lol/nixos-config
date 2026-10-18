_: {
  hosts.apollo = {
    enable = true;
    hostName = "apollo";
    stateVersion = "26.05";

    users.ar175 = {
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

          gpu = {
            intel.enable = true;
            nvidia.enable = true;
          };
        };

        system = {
          loader.enable = true;
          fonts.enable = true;
          automount.enable = true;

          programs.minecraft.offlineUsername = "ar175";
        };

        profiles = {
          workstation.enable = true;
          gaming.enable = true;
        };
      };
    };

    extraModules = [./fs.nix];
  };
}
