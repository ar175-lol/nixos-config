{mkModuleOption, ...}: {
  options.nixos.users = {
    ar175 = mkModuleOption {key = "users-ar175";};
    kirk = mkModuleOption {key = "users-kirk";};
  };

  config.nixos.users = {
    ar175 = {pkgs, ...}: {
      users.users.ar175 = {
        isNormalUser = true;
        shell = pkgs.zsh;
        hashedPassword = "$6$4ObEABrHkyfFS35K$DkgMD.MLEY7N0FQehWWlJBvrFlmZS9kX3cNQ1L6Gok0VAsMFrRhdX1PoBgV7uC0NFzmzyZAQ2u6PW4jPSZV5M.";
        description = "ar175";
        extraGroups = ["wheel" "video" "audio" "input" "adbusers"];
      };

      programs.zsh.enable = true;

      security = {
        sudo.enable = false;
        doas = {
          enable = true;
          wheelNeedsPassword = false;
          extraRules = [
            {
              groups = ["wheel"];
              noPass = true;
              setEnv = ["SSH_AUTH_SOCK" "TERMINFO" "TERMINFO_DIRS"];
              runAs = "any";
            }
          ];
        };
      };
    };

    kirk = {pkgs,...}: {
      users.users.kirk = {
        isNormalUser = true;
        shell = pkgs.fish;
        hashedPassword = "$6$kbiOzcmbb755xoLr$eGNZKNOFh9P0.knRyQj72eT2HxLgx9VROYeyjgQXSP0hx1RXcMx9Fvmde0ubFOQrOt3HS3eDM8EOcG1JoPXwm0";
        description = "kirk";
        extraGroups = ["wheel" "video" "audio" "input" "adbusers"];
      };
      programs.fish.enable = true;
    };
  };
}
