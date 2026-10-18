{
  config,
  lib,
  ...
}: let
  cfg = config.modules.device.hasBluetooth;
in {
  config = lib.mkIf cfg {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
          KernelExperimental = true;
        };
        Policy.AutoEnable = true;
      };
    };
  };
}
