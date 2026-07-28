_: {
  nixos.base = {
    users.users = {
      ar175 = {
        isNormalUser = true;
        hashedPassword = "$6$nxk4tJSRBd8udBQm$rKcgUIaowcy8TKnMwTAcLcrjGyBL.qs4b75dxRUT4GSB75txej3rEZ6R40Bg6Adh6vq3cHhOLtxPJljhzUvIy1";
        description = "ar175";
        extraGroups = [
          "wheel"
          "networkmanager"
          "video"
          "audio"
          "libvirtd"
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
            keepEnv = true;
            setEnv = ["SSH_AUTH_SOCK" "TERMINFO" "TERMINFO_DIRS"];
            runAs = "any";
          }
        ];
      };
    };
  };
}
