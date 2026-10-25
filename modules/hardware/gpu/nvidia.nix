{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.device.gpu.nvidia;
in {
  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      services.xserver.videoDrivers = ["nvidia"];

      boot.kernelParams = ["nvidia-drm.modeset=1"];

      hardware = {
        nvidia = {
          package = config.boot.kernelPackages.nvidiaPackages.latest;
          modesetting.enable = true;
          open = false;
          nvidiaSettings = false;

          powerManagement = {
            enable = true;
            finegrained = true;
          };
        };

        graphics = {
          enable = true;
          enable32Bit = true;
          extraPackages = [pkgs.nvidia-vaapi-driver];
        };
      };

      environment.systemPackages = [
        pkgs.vulkan-tools
        pkgs.libva-utils
      ];
    }

    (lib.mkIf cfg.prime.enable {
      hardware.nvidia.prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        inherit (cfg.prime) intelBusId nvidiaBusId;
      };
    })
  ]);
}
