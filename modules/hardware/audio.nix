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
      };
    };
    security.rtkit.enable = true;
  };
}
