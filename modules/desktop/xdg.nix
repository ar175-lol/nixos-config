_: {
  nixos.desktop = {
    pkgs,
    lib,
    ...
  }: {
    xdg.portal = {
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
}
