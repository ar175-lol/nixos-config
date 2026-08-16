_: {
  users.ar175.nixos.pc = {pkgs, ...}: {
    hardware.cpu.intel.updateMicrocode = true;

    boot.kernelParams = ["i915.enable_guc=3"];

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };

    hardware.graphics.extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
    ];
  };
}
