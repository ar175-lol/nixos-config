_: {
  users.ar175.nixos.pc = {
    config,
    pkgs,
    ...
  }: {
    services.xserver.videoDrivers = ["nvidia"];

    boot.kernelParams = [
      "nvidia-drm.modeset=1"
    ];

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

        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };

      graphics = {
        enable = true;
        enable32Bit = true;

        extraPackages = with pkgs; [
          nvidia-vaapi-driver
          intel-vaapi-driver
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      vulkan-tools
      libva-utils
    ];
  };
}
