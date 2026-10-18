{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.greeter;
in {
  imports = [inputs.noctalia-greeter.nixosModules.default];

  config = lib.mkIf cfg.enable {
    console.useXkbConfig = false;

    services.displayManager.noctalia-greeter = {
      enable = true;

      settings = {
        cursor = {
          theme = "Bibata-Modern-Classic";
          size = 24;
          path = "${pkgs.bibata-cursors}/share/icons";
        };
        keyboard = {
          layout = "us,ru";
          options = "grp:alt_shift_toggle";
        };
      };
    };
  };
}
