_: {
  nixos.desktop = {
    pkgs,
    lib,
    ...
  }: {
    xdg = {
      portal = {
        enable = true;

        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
        ];

        config = {
          common.default = ["gnome"];

          niri = {
            "org.freedesktop.impl.portal.Inhibit" = lib.mkForce ["none"];
          };
        };
      };
    };
  };
  homeManager.ar175 = {config, ...}: {
    xdg = {
      userDirs = {
        enable = true;

        createDirectories = true;

        download = "${config.home.homeDirectory}/Downloads";
        desktop = "${config.home.homeDirectory}/Desktop";
        documents = "${config.home.homeDirectory}/Documents";
        music = "${config.home.homeDirectory}/Music";
        videos = "${config.home.homeDirectory}/Videos";
        pictures = "${config.home.homeDirectory}/Pictures";

        templates = null;
        publicShare = null;
      };
      mimeApps.enable = true;
    };
  };
}
