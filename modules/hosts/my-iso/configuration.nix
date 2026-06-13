{...}: {
  flake.nixosModules.myIsoConfiguration = {
    pkgs,
    config,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      telegram-desktop
      git
      neovim
    ];

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };

    hardware = {
      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.latest;
        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;
      };

      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [egl-wayland];
      };
    };

    services.xserver.videoDrivers = ["nvidia"];

    programs.fish.enable = true;

    services = {
      desktopManager.plasma6.enable = true;
      displayManager = {
        autoLogin = {
          enable = true;
          user = "nixos";
        };
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
    };

    nixpkgs = {
      hostPlatform = "x86_64-linux";
      config.allowUnfree = true;
    };
    nix.settings.experimental-features = ["nix-command" "flakes"];
  };
}
