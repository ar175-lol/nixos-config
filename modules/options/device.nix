{lib, ...}: let
  inherit (lib) mkOption;
  inherit (lib.types) bool;
in {
  options.modules.device = {
    hasSound = mkOption {
      type = bool;
      default = false;
      description = "Whether the host has usable audio hardware.";
    };

    hasBluetooth = mkOption {
      type = bool;
      default = false;
      description = "Whether the host has a Bluetooth radio.";
    };

    gpu = {
      intel.enable = mkOption {
        type = bool;
        default = false;
        description = "Whether the host has integrated Intel graphics.";
      };

      nvidia.enable = mkOption {
        type = bool;
        default = false;
        description = "Whether the host has a dedicated NVIDIA GPU.";
      };
    };
  };
}
