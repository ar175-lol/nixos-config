{self, ...}: {
  users.nixos.nixos.pc = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.myNvf];
  };
}
