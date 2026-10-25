{
  lib,
  config,
  ...
}: let
  cfg = config.modules.device.cpu;
in {
  config = lib.mkIf (cfg.type == "intel") {
    hardware.cpu.intel.updateMicrocode = true;
  };
}
