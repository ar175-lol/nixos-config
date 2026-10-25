{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.device.gpu.intel;
in {
  config = lib.mkIf cfg.enable {
    boot.kernelParams = ["i915.enable_guc=3"];

    environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

    hardware.graphics.extraPackages = [
      pkgs.intel-vaapi-driver
      pkgs.intel-media-driver
      pkgs.intel-compute-runtime
      pkgs.vpl-gpu-rt
    ];
  };
}
