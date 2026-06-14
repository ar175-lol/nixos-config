{self, ...}: {
  flake.nixosModules.myVictusConfiguration = {pkgs, ...}: {
    imports = [
      # network
      self.nixosModules.dnscryptConfiguration
      self.nixosModules.iwdConfiguration
      self.nixosModules.firewallConfiguration
      self.nixosModules.warpConfiguration
      # services
      self.nixosModules.pipewireConfiguration
      self.nixosModules.autocpufreqConfiguration
      self.nixosModules.xserverConfiguration
      self.nixosModules.systemDebloatConfiguration
      # hardware
      self.nixosModules.bluetoothConfiguration
      self.nixosModules.nvidiaConfiguration
      self.nixosModules.zramConfiguration
      self.nixosModules.kernelConfiguration
      self.nixosModules.automountConfiguration
      # core
      self.nixosModules.systemdBootConfiguration
      self.nixosModules.nixConfiguration
      self.nixosModules.usersConfiguration
      # desktop
      self.nixosModules.xdgConfiguration
      self.nixosModules.myCursor
      # packages
      self.nixosModules.niri
      self.nixosModules.yaziConfiguration
      self.nixosModules.myKitty
      self.nixosModules.myNvim
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

    system.stateVersion = "26.05";
  };
}
