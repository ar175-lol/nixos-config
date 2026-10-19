{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.telegram;

  telegram = pkgs.telegram-desktop;

  telegramPortal = pkgs.symlinkJoin {
    name = "${telegram.name}-portal-filechooser";
    paths = [telegram];
    postBuild = ''
      rm -f $out/bin/Telegram
      cat >$out/bin/Telegram <<'EOF'
      #!@shell@
      exec env QT_QPA_PLATFORMTHEME=xdgdesktopportal @telegram@/bin/Telegram "$@"
      EOF
      chmod +x $out/bin/Telegram
      substituteInPlace $out/bin/Telegram \
        --replace-fail '@shell@' '${pkgs.runtimeShell}' \
        --replace-fail '@telegram@' '${telegram}'
    '';
  };

  home = {
    home.packages = [telegramPortal];
    xdg.mimeApps.defaultApplicationPackages = [telegramPortal];
  };
in {
  config = lib.mkIf cfg.enable {
    home-manager.sharedModules = [home];
  };
}
