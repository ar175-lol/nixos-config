_: {
  flake.nixosModules.nvidiaConfiguration = {
    config,
    pkgs,
    ...
  }: {
    services.xserver.videoDrivers = ["nvidia"];

    hardware = {
      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.latest;
        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;

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
          intel-media-driver
          libvdpau-va-gl
          nvidia-vaapi-driver
          intel-vaapi-driver
          vulkan-loader
          libva
          mesa
          egl-wayland
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      vulkan-tools
      libva-utils
      qbittorrent
    ];
  };
}
