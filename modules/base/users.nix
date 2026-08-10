{mkModuleOption, ...}: {
  options.nixos.users = {
    ar175 = mkModuleOption {key = "users-ar175";};
    kirk = mkModuleOption {key = "users-kirk";};
  };

  config.nixos.users = {
    ar175 = _: {
      users.users.ar175 = {
        isNormalUser = true;
        hashedPassword = "$6$4ObEABrHkyfFS35K$DkgMD.MLEY7N0FQehWWlJBvrFlmZS9kX3cNQ1L6Gok0VAsMFrRhdX1PoBgV7uC0NFzmzyZAQ2u6PW4jPSZV5M.";
        description = "ar175";
        extraGroups = ["wheel" "video" "audio" "input" "adbusers"];
      };
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

    kirk = _: {
      users.users.kirk = {
        isNormalUser = true;
        description = "kirk";
        extraGroups = ["wheel" "video" "audio" "input" "adbusers"];
      };
    };
  };
}
