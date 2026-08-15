_: {
  users.ar175.nixos.pc = {
    pkgs,
    lib,
    ...
  }: {
    xdg.portal = {
      extraPortals = [pkgs.xdg-desktop-portal-gnome];
      config.niri = {
        default = lib.mkForce ["gnome"];
        "org.freedesktop.impl.portal.FileChooser" = ["gnome"];
        "org.freedesktop.impl.portal.Inhibit" = lib.mkForce ["none"];
      };
    };
  };
}
