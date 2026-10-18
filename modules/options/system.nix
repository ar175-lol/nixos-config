# System-level toggles that are neither programs nor device facts.
{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.modules.system = {
    loader.enable = mkEnableOption "the Limine boot loader";
    doas.enable = mkEnableOption "doas in place of sudo";
    fonts.enable = mkEnableOption "the nixpkgs default font set";

    zram.enable = mkEnableOption "zram swap";
    powerSave.enable = mkEnableOption "power saving defaults (undervolt, thermald, power profiles)";
    automount.enable = mkEnableOption "user automount rules";
  };
}
