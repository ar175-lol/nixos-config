_: {
  users.nixos.nixos.pc = {
    self,
    pkgs,
    ...
  }: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.myNvf];
  };
}
