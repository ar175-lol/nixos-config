_: {
  users.ar175.nixos.pc = {
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
}
