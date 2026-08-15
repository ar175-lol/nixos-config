{
  config,
  inputs,
  self,
  ...
}: {
  nixos.configurations.iso.modules = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix"

    config.nixos.modules.base
    config.users.nixos.nixos.base

    {
      home-manager.backupFileExtension = "backup";
    }

    ({
      pkgs,
      lib,
      ...
    }: {
      nixpkgs.hostPlatform = "x86_64-linux";
      hardware.enableRedistributableFirmware = true;

      fonts = {
        packages = with pkgs; [nerd-fonts.jetbrains-mono];
        fontconfig = {
          enable = true;
          defaultFonts.monospace = ["JetBrainsMono Nerd Font"];
        };
      };

      services = {
        displayManager.autoLogin = {
          enable = true;
          user = "nixos";
        };
        greetd = {
          enable = true;
          settings.default_session = {
            command = "${pkgs.dbus}/bin/dbus-run-session ${self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri}/bin/niri --session";
            user = "nixos";
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
        networkmanager.enable = lib.mkForce false;
        dhcpcd.enable = true;
        wireless.enable = lib.mkForce false;
      };

      users.users.nixos.shell = pkgs.fish;

      boot.kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest;

      environment.systemPackages = with pkgs; [
        debootstrap
        arch-install-scripts
        testdisk
        ddrescue
        chntpw
        ms-sys
        firefox
        calamares-nixos
      ];
    })
  ];

  users.nixos.home.base = {
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
    };

    home.packages = with pkgs; [
      neovim
      git
      gcc
      ripgrep
      fd
    ];

    programs.rustbar.enable = true;
  };
}
