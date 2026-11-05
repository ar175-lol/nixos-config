{inputs, ...}: {
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
      # TODO: move it to somewhere...
      environment.systemPackages = [inputs.pwsp.packages.x86_64-linux.default];

      # TODO: move it to sddm config?
      security.polkit.extraConfig = ''
        polkit.addRule(function(action, subject) {
          var powerActions = [
            "org.freedesktop.login1.power-off",
            "org.freedesktop.login1.power-off-multiple-sessions",
            "org.freedesktop.login1.power-off-ignore-inhibit",
            "org.freedesktop.login1.reboot",
            "org.freedesktop.login1.reboot-multiple-sessions",
            "org.freedesktop.login1.reboot-ignore-inhibit",
            "org.freedesktop.login1.suspend",
            "org.freedesktop.login1.suspend-multiple-sessions",
            "org.freedesktop.login1.suspend-ignore-inhibit",
            "org.freedesktop.login1.hibernate",
            "org.freedesktop.login1.hibernate-multiple-sessions",
            "org.freedesktop.login1.hibernate-ignore-inhibit",
            "org.freedesktop.login1.hybrid-sleep",
            "org.freedesktop.login1.hybrid-sleep-multiple-sessions",
            "org.freedesktop.login1.hybrid-sleep-ignore-inhibit",
            "org.freedesktop.login1.suspend-then-hibernate",
            "org.freedesktop.login1.suspend-then-hibernate-multiple-sessions",
            "org.freedesktop.login1.suspend-then-hibernate-ignore-inhibit"
          ];

          if ((subject.isInGroup("wheel") || subject.user == "sddm")
              && powerActions.indexOf(action.id) !== -1) {
            return polkit.Result.YES;
          }
        });
      '';

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
            steam.enable = false;
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
