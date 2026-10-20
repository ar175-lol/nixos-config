{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.localsend;
in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.localsend];

    networking.firewall = {
      allowedTCPPorts = [53317];
      allowedUDPPorts = [53317];
    };
  };
}
