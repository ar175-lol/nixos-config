_: {
  flake.nixosModules.myVictusHardware = {
    config,
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-intel"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/fa37a150-d297-4056-a4fc-ea56431cbd95";
      fsType = "btrfs";
      options = ["subvol=root" "compress=zstd" "noatime"];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/fa37a150-d297-4056-a4fc-ea56431cbd95";
      fsType = "btrfs";
      options = ["subvol=home" "compress=zstd"];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/fa37a150-d297-4056-a4fc-ea56431cbd95";
      fsType = "btrfs";
      options = ["subvol=nix" "compress=zstd" "noatime"];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/1E13-C40B";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
