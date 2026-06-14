{...}: {
  flake.homeModules.myCursor = {pkgs, ...}: {
    home = {
      pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
      };
      sessionVariables = {
        XCURSOR_THEME = "Bibata-Modern-Classic";
        XCURSOR_SIZE = "24";
      };

      packages = with pkgs; [
        bibata-cursors
      ];
    };
  };
  flake.nixosModules.myCursor = {...}: {
    programs.dconf.enable = true;
  };
}
