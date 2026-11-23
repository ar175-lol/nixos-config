{
  lib,
  pkgs,
  inputs,
  osConfig,
  ...
}: let
  cfg = osConfig.modules.system.programs.drift;
in {
  config = lib.mkIf cfg.enable {
    home.packages = [inputs.drift.packages.${pkgs.stdenv.hostPlatform.system}.default];

    xdg.configFile."drift/config.toml".text = ''
      # DO NOT EDIT

      [playback]
      volume = 50
      shuffle = true
      repeat = "all"
      autoplay = false
      restore_session = true
      seek_step = 5.0
      volume_step = 5.0

      [discord]
      client_id = "1573318216548360232"

      [ui]
      accent = "#cba6f7"

      [audio]
      download = true
      download_max_minutes = 15
      download_dir = "~/Music/drift"
      cookies_from_browser = ""
    '';
  };
}
