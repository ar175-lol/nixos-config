{self, ...}: {
  nixos.iso = {
    lib,
    pkgs,
    ...
  }: {
    nixpkgs.hostPlatform = "x86_64-linux";

    fonts = {
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = ["JetBrainsMono Nerd Font"];
        };
      };
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services = {
      displayManager.autoLogin = {
        enable = true;
        user = "nixos";
      };
      greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.dbus}/bin/dbus-run-session ${self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri}/bin/niri --session";
            user = "nixos";
          };
        };
      };
      speechd.enable = false;
    };

    programs = {
      niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };

      fish.enable = true;
    };

    networking.wireless.enable = lib.mkForce false;
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest;

    environment.systemPackages = with pkgs; [
      debootstrap
      arch-install-scripts
      testdisk
      ddrescue
      parted

      chntpw
      ms-sys
      xwayland
      xwayland-satellite

      firefox
    ];
  };

  homeManager.nixos = {
    inputs,
    pkgs,
    ...
  }: {
    imports = [
      inputs.rustbar.homeModules.default
      inputs.mako-rs.homeModules.default
    ];

    home = {
      username = "nixos";
      homeDirectory = "/home/nixos";
      stateVersion = "26.11";
    };

    home.packages = with pkgs; [
      neovim
      git
      gnumake
      unzip
      gcc
      ripgrep
      fd
    ];

    xdg.configFile."nvim" = {
      source = ../../dev/nvim;
      recursive = true;
    };

    programs = {
      rustbar = {
        enable = true;
      };
      mako-rs.enable = true;
    };
  };
}
