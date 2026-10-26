{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.modules.style = {};
}
