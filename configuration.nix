{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Boot settings
   boot = {
   # Disable systemd-boot
   loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      timeout = 0;

      # Grub
      grub = {
          enable = true;
          device = "nodev";
          efiSupport = true;
          useOSProber = true;
        };
      };

      # Silent boot
      plymouth = {
        enable = true;
        theme = "breeze";
      };
      kernelParams = [
        "quiet"
        "splash"
        "vga=current"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
        "nvidia-drm.modeset=1"
      ];

      # Kernel
      kernelPackages = pkgs.linuxPackages_xanmod;
   };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
  };
  
  nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
        };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      };
    };
  };


  # Services
  services = {
  # Sound
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
    # KDE Plasma
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # X11
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
    };
  };

  # Networking 
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [80 443];
      allowedUDPPortRanges = [
        { from = 1714; to = 1764; }
      ];
    };
  };

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Asia/Almaty";

  # Users
   users.users.ar175 = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "1";
    shell = pkgs.fish;
  };

  # Programs
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    nixd
    statix
    efibootmgr
    nix-output-monitor
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05"; 

}
