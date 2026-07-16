_: {
  nixos.victus = _: {
    virtualisation = {
      libvirtd = {
        enable = true;
        onBoot = "ignore";
        onShutdown = "suspend";
      };
    };
    users.users.ar175.extraGroups = ["libvirtd"];

    programs.virt-manager.enable = true;

    networking.firewall.trustedInterfaces = ["virbr0"];
  };
}
