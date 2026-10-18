{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.programs.virtualisation;
in {
  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "suspend";
    };

    users.users.ar175.extraGroups = lib.mkAfter ["libvirtd"];

    programs.virt-manager.enable = true;

    networking.firewall.trustedInterfaces = ["virbr0"];
  };
}
