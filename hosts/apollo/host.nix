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
        hashedPassword = "$6$4ObEABrHkyfFS35K$DkgMD.MLEY7N0FQehWWlJBvrFlmZS9kX3cNQ1L6Gok0VAsMFrRhdX1PoBgV7uC0NFzmzyZAQ2u6PW4jPSZV5M.";
        extraGroups = [
          "wheel"
          "video"
          "audio"
          "input"
          "adbusers"
        ];
      };
      mom = {
        description = "mom";
        shell = "fish";
        defaultSession = "plasma";
        hashedPassword = "$6$1yVg1hiI8fUALOA3$qx361OrYq6OuJFH/eHs6dIsqAU7FRPJc.VY0HkrDQiMj189Gw4U5RSmQ4P8a9A1CTcI3mEqblYmj17dD1GQdo/";
        extraGroups = [
          "video"
          "audio"
          "input"
        ];
      };
    };

    roles = [
      "graphical"
      "workstation"
      "laptop"
    ];

    features = {
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
            steam.enable = true;
            flatpak.enable = true;
          };

          loader.enable = true;
          fonts.enable = true;
          automount.enable = true;
        };

        profiles.workstation.enable = true;
      };
    };

    extraModules = [./fs.nix];
  };
}
