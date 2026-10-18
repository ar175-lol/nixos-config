{
  lib,
  inputs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.ncalayer;
in {
  imports = [inputs.ncalayer.nixosModules.default];

  config = lib.mkIf cfg.enable {
    services.ncalayer.enable = true;
  };
}
