{
  inputs,
  self,
  ...
}: {
  nixos.desktop = {pkgs, ...}: {
    programs.yazi = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myYazi;
    };
  };

  perSystem = {pkgs, ...}: {
    packages.myYazi = inputs.wrapper-modules.wrappers.yazi.wrap {
      inherit pkgs;
      settings.yazi = {
        mgr = {
          sort_sensitive = false;
          sort_by = "none";
          sort_dir_first = true;
          show_hidden = true;
          show_symlink = true;
        };
      };
    };
  };
  homeManager.ar175 = _: {
    xdg.mimeApps.defaultApplications = {
      "inode/directory" = ["yazi.desktop"];
    };
  };
}
