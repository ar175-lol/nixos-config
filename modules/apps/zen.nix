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
                position = 100;
              };
              "Proton Mail" = {
                id = "2db3e219-d8bf-4e30-8633-dc5d9c6a3617";
                url = "https://mail.proton.me/u/0/inbox";
                position = 110;
              };
            };
          };
          "Dev" = {
            id = "3e94141e-d73f-44b4-8f28-ac5199d2399c";
            position = 2000;

            pins = {
              "GitHub" = {
                id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
                url = "https://github.com";
                position = 200;
              };
              "The Book (Rust)" = {
                id = "960f794b-aa51-430c-8ed4-605bd38591a9";
                url = "https://doc.rust-lang.org/stable/book/";
                position = 210;
              };

              "Nix & NixOS" = {
                id = "101fcfd8-313c-4c8d-8abc-8f1eac79f542";
                isGroup = true;
                position = 230;
                pins = {
                  "NixOS options" = {
                    id = "35fddde4-aed6-48c0-a740-0fd1688d728b";
                    url = "https://search.nixos.org/options";
                    position = 235;
                  };
                  "MyNixOS" = {
                    id = "f6fd888d-d1fa-4e6b-934b-122cea186ebf";
                    url = "https://mynixos.com/";
                    position = 236;
                  };
                };
              };
            };

            liveFolders = {
              "My Pull Requests" = {
                id = "b7a3d5c1-9e2f-4a68-b0d4-6f1c8e5a2d93";
                kind = "github:pull-requests";
                position = 250;
                github.authorMe = true;
              };
              "My Issues" = {
                id = "56e9a42b-def8-476c-9926-149e695ba32c";
                kind = "github:issues";
                position = 260;
                github.authorMe = true;
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
            id = "zen-copy_url";
            disabled = true;
          }
          {
            id = "addBookmarkAsKb";
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
      flavor = "Mocha";
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
