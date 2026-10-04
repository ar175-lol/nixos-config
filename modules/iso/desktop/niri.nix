{self, ...}: {
  users.nixos.nixos.pc = {
    pkgs,
    config,
    ...
  }: {
    programs.niri = {
      enable = true;
      useNautilus = false;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri.override {
        hostName = config.networking.hostName;
      };
    };
  };
}
