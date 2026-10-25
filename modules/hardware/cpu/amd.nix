{
  lib,
  config,
  ...
}: let
  cfg = config.modules.device.cpu;
in {
  config = lib.mkIf (cfg.type == "amd") {
    hardware.cpu.amd.updateMicrocode = true;
  };
}
