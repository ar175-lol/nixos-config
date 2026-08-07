{self, ...}: {
  nixos.iso = {
    lib,
    pkgs,
    ...
  }: {
    nixpkgs.hostPlatform = "x86_64-linux";

    hardware.enableRedistributableFirmware = true;

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

    networking = {
      useNetworkd = true;

      networkmanager.enable = lib.mkForce false;
      dhcpcd.enable = false;
      wireless.enable = lib.mkForce false;

      wireless.iwd = {
        enable = true;
        settings = {
          Network = {
            EnableIPv6 = false;
            NameResolvingService = "none";
          };
          General = {
            EnableNetworkConfiguration = true;
            AddressRandomization = "network";
            AddressRandomizationRange = "full";
            ManagementFrameProtection = "1";
            ControlPortOverNL80211 = true;
            DisableANQP = true;
          };
          Settings = {
            AutoConnect = true;
          };
        };
      };
    };

    users.users.nixos = {
      shell = pkgs.fish;
    };

    systemd.network.networks."10-ethernet-dhcp" = {
      matchConfig.Name = "en* eth*";
      networkConfig = {
        DHCP = "ipv4";
      };
    };

    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest;

    environment.systemPackages = with pkgs; [
      debootstrap
      arch-install-scripts
      testdisk
      ddrescue

      chntpw
      ms-sys

      firefox
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];
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
      gcc
      ripgrep
      fd
    ];

    xdg.configFile."nvim" = {
      source = ../../../dots/nvim/.;
      recursive = true;
    };

    programs.rustbar.enable = true;
  };
}
