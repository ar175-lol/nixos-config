_: {
  users.ar175.nixos.pc = {
    config,
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot = {
      initrd = {
        availableKernelModules = ["xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
        kernelModules = [];
      };
      kernelModules = ["kvm-intel"];
      extraModulePackages = [];
    };

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/fa37a150-d297-4056-a4fc-ea56431cbd95";
        fsType = "btrfs";
        options = ["x-initrd.mount" "subvol=root" "compress=zstd" "noatime"];
      };
      "/home" = {
        device = "/dev/disk/by-uuid/fa37a150-d297-4056-a4fc-ea56431cbd95";
        fsType = "btrfs";
        options = ["subvol=home" "compress=zstd"];
      };
      "/nix" = {
        device = "/dev/disk/by-uuid/fa37a150-d297-4056-a4fc-ea56431cbd95";
        fsType = "btrfs";
        options = ["x-initrd.mount" "subvol=nix" "compress=zstd" "noatime"];
      };
      "/boot" = {
        device = "/dev/disk/by-uuid/1E13-C40B";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022"];
      };
    };

    swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
