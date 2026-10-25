{lib, ...}: let
  inherit (lib) mkOption;
  inherit (lib.types) bool enum nullOr str;
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

    cpu = {
      type = mkOption {
        type = nullOr (enum ["intel" "amd"]);
        default = null;
        description = "CPU vendor, used for microcode updates.";
      };
    };

    gpu = {
      intel.enable = mkOption {
        type = bool;
        default = false;
        description = "Whether the host has integrated Intel graphics.";
      };

      nvidia = {
        enable = mkOption {
          type = bool;
          default = false;
          description = "Whether the host has a dedicated NVIDIA GPU.";
        };

        prime = {
          enable = mkOption {
            type = bool;
            default = false;
            description = "Whether NVIDIA PRIME offload should be configured.";
          };

          intelBusId = mkOption {
            type = str;
            default = "PCI:0:2:0";
            description = "PCI bus ID of the Intel GPU for PRIME.";
          };

          nvidiaBusId = mkOption {
            type = str;
            default = "PCI:1:0:0";
            description = "PCI bus ID of the NVIDIA GPU for PRIME.";
          };
        };
      };
    };
  };
}
