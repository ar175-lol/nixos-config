{self, ...}: {
  users.ar175.nixos.pc = {
    pkgs,
    lib,
    ...
  }: let
    inherit (self.packages.${pkgs.stdenv.hostPlatform.system}) myTerminal myYazi;

    chooserWrapper = pkgs.writeShellScript "termfilechooser-yazi" ''
      multiple="$1"
      directory="$2"
      save="$3"
      path="$4"
      out="$5"
      debug="$6"

      set -e
      if [ "$debug" = 1 ]; then
        set -x
      fi

      term="${lib.getExe myTerminal}"
      yazi="${lib.getExe myYazi}"

      if [ ! -e "$path" ]; then
        path="$HOME"
      fi

      args=(--chooser-file="$out")
      if [ "$directory" = 1 ]; then
        args+=(--cwd-file="$out".1)
      fi
      args+=("$path")

      "$term" --app-id=termfilechooser --title=termfilechooser -e "$yazi" "''${args[@]}"

      if [ "$directory" = 1 ]; then
        if [ ! -s "$out" ] && [ -s "$out".1 ]; then
          cat "$out".1 > "$out"
        fi
        rm -f "$out".1
      fi
    '';
  in {
    xdg.portal = {
      extraPortals = [pkgs.xdg-desktop-portal-gnome pkgs.xdg-desktop-portal-termfilechooser];
      config.niri = {
        default = lib.mkForce ["gnome"];
        "org.freedesktop.impl.portal.FileChooser" = lib.mkForce ["termfilechooser"];
        "org.freedesktop.impl.portal.Inhibit" = lib.mkForce ["none"];
      };
    };

    environment.etc."xdg/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh" = {
      source = chooserWrapper;
      mode = "0555";
    };
  };

  users.ar175.home.gui.xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=/etc/xdg/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
  '';
}
