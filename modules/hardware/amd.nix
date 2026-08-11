{mkModuleOption, ...}: {
  options.nixos.hardware.amd = mkModuleOption {key = "amd";};

  config.nixos.hardware.amd = {pkgs, ...}: {
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
