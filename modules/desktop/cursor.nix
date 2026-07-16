_: {
  homeManager.ar175 = {pkgs, ...}: {
    home = {
      pointerCursor = {
        enable = true;
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
      };

      packages = with pkgs; [bibata-cursors];
    };
  };
}
