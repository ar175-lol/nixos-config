#
{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.doas;
in {
  config = lib.mkIf cfg.enable {
    security = {
      sudo.enable = false;
      doas = {
        enable = true;
        wheelNeedsPassword = false;
        extraRules = [
          {
            groups = ["wheel"];
            noPass = true;
            setEnv = [
              "SSH_AUTH_SOCK"
              "TERMINFO"
              "TERMINFO_DIRS"
            ];
            runAs = "any";
          }
        ];
      };
    };
  };
}
