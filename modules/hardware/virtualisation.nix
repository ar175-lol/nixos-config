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

    programs.virt-manager.enable = true;

    networking.firewall.trustedInterfaces = ["virbr0"];
  };
}
