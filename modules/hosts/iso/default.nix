{
  config,
  inputs,
  lib,
  ...
}: {
  nixos.configurations.iso = {
    modules = [
      "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix"

      config.nixos.iso
      {
        networking = {
          networkmanager.enable = lib.mkForce false;
          dhcpcd.enable = false;

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
              Rank = {
                BandModifier2_4GHz = 0.5;
                BandModifier5GHz = 1.5;
              };
              Settings = {
                AutoConnect = true;
              };
            };
          };
        };
      }
      inputs.home-manager.nixosModules.default

      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit inputs;
            shell = config.nixos.shell;
          };
          backupFileExtension = "backup";
          users.nixos = config.homeManager.nixos;
        };
      }
    ];
  };
}
