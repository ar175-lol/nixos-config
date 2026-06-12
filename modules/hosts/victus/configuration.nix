{self, ...}: {
  flake.nixosModules.myVictusConfiguration = {pkgs, ...}: {
    imports = [
      self.nixosModules.networkBundle
      self.nixosModules.servicesBundle
      self.nixosModules.hardwareBundle
      self.nixosModules.coreBundle

      self.nixosModules.desktopBundle
      self.nixosModules.packagesBundle
    ];
    networking.hostName = "victus";
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      jetbrains-mono
    ];
    programs.steam.enable = true;

    environment.systemPackages = with pkgs; [nh];

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      NH_FLAKE = "/home/ar175/nix-test-v2";
    };
  };
}
