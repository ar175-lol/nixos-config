{
  config,
  lib,
  ...
}: let
  cfg = config.modules.device.hasSound;
in {
  config = lib.mkIf cfg {
    services = {
      pulseaudio.enable = false;
      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        jack.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
        extraConfig."pipewire-pulse"."10-block-source-volume" = {
          "pulse.rules" = [
            {
              matches = [
                {"application.name" = "equibop";}
                {"application.process.binary" = "electron";}
              ];
              actions.quirks = ["block-source-volume"];
            }
          ];
        };
      };
    };
    security.rtkit.enable = true;
  };
}
