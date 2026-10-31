{
  lib,
  inputs,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.system.programs.greeter;
  themePackage = inputs.sddm-astronaut-theme.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
    font = "Monocraft";
  };
in {
  config = lib.mkIf cfg.enable {
    console.useXkbConfig = false;

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "${themePackage}/share/sddm/themes/sddm-astronaut-theme";
      extraPackages = with pkgs.kdePackages; [
        qtmultimedia
        qtvirtualkeyboard
      ];
    };
  };
}
