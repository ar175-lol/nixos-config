{inputs, ...}: {
  nixos.home = {pkgs, ...}: {
    imports = [inputs.zen-browser.homeModules.twilight];

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      policies = import ./_policies.nix;

      profiles.default = {
        settings = {
          "zen.view.compact.enable-at-startup" = true;
          "zen.window-sync.enabled" = true;
        };

        mods = [
          "1b88a6d1-d931-45e8-b6c3-bfdca2c7e9d6"
          "a6335949-4465-4b71-926c-4a52d34bc9c0"
          "253a3a74-0cc4-47b7-8b82-996a64f030d5"
        ];

        pinsForce = true;
        pinsForceAction = "remove";

        spacesForce = true;
        spaces = {
          "Main" = {
            id = "572910e1-4468-4832-a869-0b3a93e2f165";
            position = 1000;

            pins = {
              "Youtube" = {
                id = "6cd1b145-0dbf-40d7-8cf3-f5349abd67f1";
                url = "https://youtube.com";
                position = 101;
                isEssential = true;
              };
              "GitHub" = {
                id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
                url = "https://github.com";
                position = 102;
                isEssential = true;
              };
            };

            liveFolders = {
              "Pull Requests" = {
                id = "b7a3d5c1-9e2f-4a68-b0d4-6f1c8e5a2d93";
                kind = "github:pull-requests";
                position = 401;
                github = {
                  authorMe = true;
                };
              };
            };
          };
        };

        keyboardShortcutsVersion = 19;
        keyboardShortcuts = [
          {
            id = "zen-compact-mode-toggle";
            disabled = true;
          }
          {
            id = "key_quitApplication";
            disabled = true;
          }
          {
            id = "zen-copy_current_url";
            disabled = true;
          }
        ];
      };
    };

    home.file = let
      catppuccinZen = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "zen-browser";
        rev = "c855685442c6040c4dda9c8d3ddc7b708de1cbaa";
        hash = "sha256-5A57Lyctq497SSph7B+ucuEyF1gGVTsuI3zuBItGfg4=";
      };
      flavor = "Mocha"; # change this if you want different flavor/accent
      accent = "Mauve";
    in {
      ".config/zen/default/chrome" = {
        source = "${catppuccinZen}/themes/${flavor}/${accent}";
        recursive = true;
        force = true;
      };
    };
  };
}
