{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.device.gpu.intel;
in {
  config = lib.mkIf cfg.enable {
    hardware.cpu.intel.updateMicrocode = true;

    boot.kernelParams = ["i915.enable_guc=3"];

    environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

    hardware.graphics.extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
    ];
  };
}
