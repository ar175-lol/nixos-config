{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.printing;
in {
  config = lib.mkIf cfg.enable {
    hardware.sane = {
      enable = true;
      extraBackends = [pkgs.sane-airscan];
    };

    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
        publish = {
          enable = true;
          addresses = true;
        };
      };

      printing.enable = true;
    };

    users.users.ar175.extraGroups = lib.mkAfter ["scanner" "lp"];
  };
}
