_: {
  hosts.apollo = {
    enable = true;
    hostName = "apollo";
    stateVersion = "26.05";

    users = {
      ar175 = {
        description = "ar175";
        shell = "zsh";
        defaultSession = "niri";
        extraGroups = [
          "wheel"
          "video"
          "audio"
          "input"
          "adbusers"
          "libvirtd"
          "scanner"
          "lp"
        ];
      };
      mom = {
        description = "mom";
        shell = "fish";
        defaultSession = "plasma";
        extraGroups = [
          "video"
          "audio"
          "input"
        ];
      };
    };

    features = {
      modules = {
        device = {
          hasSound = true;
          hasBluetooth = true;
          hasWifi = true;

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
          programs = {
            plasma.enable = true;
            flatpak.enable = true;
            librewolf.enable = true;
            steam.enable = true;
            drift.enable = true;
            pwsp.enable = true;
          };

          loader.enable = true;
          fonts.enable = true;
        };

        profiles = {
          graphical.enable = true;
          workstation.enable = true;
          laptop.enable = true;
          gaming.enable = true;
        };
      };
    };

    extraModules = [
      ./modules
    ];
  };
}
