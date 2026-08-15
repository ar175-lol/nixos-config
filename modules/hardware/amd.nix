_: {
  users.kirk.nixos.pc = {pkgs, ...}: {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [mesa vulkan-loader libva];
      };

      amdgpu.initrd.enable = true;

      cpu.amd.updateMicrocode = true;
      enableAllFirmware = true;
    };
  };
}
