{mkModuleOption, ...}: {
  options.nixos.users = {
    victus = mkModuleOption {key = "users-victus";};
    dkirk = mkModuleOption {key = "users-dkirk";};
  };

  config.nixos.users = {pkgs, ...}: {
    victus = {
      users.users = {
        ar175 = {
          isNormalUser = true;
          hashedPassword = "$6$4ObEABrHkyfFS35K$DkgMD.MLEY7N0FQehWWlJBvrFlmZS9kX3cNQ1L6Gok0VAsMFrRhdX1PoBgV7uC0NFzmzyZAQ2u6PW4jPSZV5M.";
          description = "ar175";
          extraGroups = [
            "wheel"
            "video"
            "audio"
            "input"
            "adbusers"
          ];
        };
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
    dkirk = {
      users.users = {
        kirk = {
          isNormalUser = true;

          description = "ar175";
          extraGroups = [
            "wheel"
            "video"
            "audio"
            "input"
            "adbusers"
          ];
        };
      };
    };
  };
  # nixos.base = {
  #   users.users = {
  #     ar175 = {
  #       isNormalUser = true;
  #       hashedPassword = "$6$nxk4tJSRBd8udBQm$rKcgUIaowcy8TKnMwTAcLcrjGyBL.qs4b75dxRUT4GSB75txej3rEZ6R40Bg6Adh6vq3cHhOLtxPJljhzUvIy1";
  #       description = "ar175";
  #       extraGroups = [
  #         "wheel"
  #         "video"
  #         "audio"
  #         "input"
  #         "adbusers"
  #       ];
  #     };
  #   };
  #   security = {
  #     sudo.enable = false;
  #     doas = {
  #       enable = true;
  #       wheelNeedsPassword = false;
  #
  #       extraRules = [
  #         {
  #           groups = ["wheel"];
  #           noPass = true;
  #           setEnv = ["SSH_AUTH_SOCK" "TERMINFO" "TERMINFO_DIRS"];
  #           runAs = "any";
  #         }
  #       ];
  #     };
  #   };
  # };
}
