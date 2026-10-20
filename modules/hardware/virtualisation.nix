{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.system.programs.virtualisation;
in {
  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd = {
      enable = true;
      onBoot = "ignore";
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
      onShutdown = "suspend";
    };

    users.users.ar175.extraGroups = lib.mkAfter ["libvirtd"];

    programs.virt-manager.enable = true;

    networking.firewall.trustedInterfaces = ["virbr0"];
  };
}
