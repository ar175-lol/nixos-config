{
  inputs,
  self,
  ...
}: {
  perSystem = {
    pkgs,
    ...
  }: {
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)).settings;

      outOfStoreConfig = "/home/ar175/.config/noctalia";
    };
  };

  users.ar175.nixos.pc = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia];
  };
}
