{
  self,
  inputs,
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

        opener = {
          edit = [
            {
              run = "nvim %s";
              block = true;
              for = "linux";
            }
          ];

          open = [
            {
              run = "cd";
            }
          ];
        };

        open = {
          rules = [
            {
              mime = "inode/directory";
              use = "open";
            }
            {
              url = "*/";
              use = "open";
            }
            {
              url = "*.json";
              use = "edit";
            }
            {
              url = "*.nix";
              use = "edit";
            }
            {
              url = "*.conf";
              use = "edit";
            }
          ];
        };
      };
    };
  };
}
