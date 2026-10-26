{inputs, ...}: {
  imports = [inputs.ncalayer.homeModules.default];
  services.ncalayer.enable = true;
}
