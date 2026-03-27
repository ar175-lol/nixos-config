{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./modules/plasma.nix
    ];

   # Bootloader
  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
    timeout = 0;

    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };

  # Plymouth 
  boot.plymouth = {
    enable = true;
    theme = "breeze";
};

  # Kernel parameters
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.kernelParams = [
    "quiet"
    "splash"
    "vga=current"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "rd.udev.log_priority=3"
    "nvidia-drm.modeset=1"
  ];

  # Pipewire
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  # SDDM
  services.displayManager = {
    enable = true;
    wayland.enable = true;
  };

  # Plasma
  services.desktopManager.plasma6.enable = true;

  # X server 
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  

  # Enable Bluetooth.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Enable OpenGL.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

# Enable NVIDIA Drivers.
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable PRIME.
  hardware.nvidia.prime = {
    offload.enable = true;
    offload.enableOffloadCmd = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };


  networking = {
    hostName = true;
    networkmanager.enable = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Asia/Almaty";

   users.users.ar175 = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "1";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    efibootmgr
  ];

  # Garbage collector
  nix.gc = {
    automatic= true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  # Features
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };
  
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05"; 

}