_: {
  homeManager.ar175 = {inputs, ...}: {
    imports = [inputs.zen-browser.homeModules.twilight];

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;
      policies = import ./_policies.nix;

      profiles.default = {
        presets.catppuccin = {
          enable = true;
          flavor = "Mocha";
          accent = "Mauve";
        };

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

        pins = {
          "Youtube" = {
            id = "98f8b1d5-e0cc-48bd-b575-e9f8d977ea1b";
            url = "https://youtube.com";
            position = 1;
            isEssential = true;
          };
          "GitHub" = {
            id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
            url = "https://github.com";
            position = 2;
            isEssential = true;
          };
        };

        spacesForce = true;
        spaces = {
          "Github" = {
            id = "3e94141e-d73f-44b4-8f28-ac5199d2399c";
            position = 1000;

            liveFolders = {
              "My Pull Requests" = {
                id = "b7a3d5c1-9e2f-4a68-b0d4-6f1c8e5a2d93";
                kind = "github:pull-requests";
                position = 150;
                github.authorMe = true;
              };
              "My Issues" = {
                id = "56e9a42b-def8-476c-9926-149e695ba32c";
                kind = "github:issues";
                position = 160;
                github.authorMe = true;
              };
            };
          };

          "Docs" = {
            id = "7d646728-211b-44c2-b507-ba1aaf4bc496";
            position = 2000;

            pins = {
              "Nix & NixOS" = {
                id = "38e9bfa2-a183-424d-bf85-664e91829a46";
                url = "https://search.nixos.org/options?channel=unstable&type=options";
                position = 2010;
              };
              # ...
            };
          };

          "AI" = {
            id = "56d4bc98-98dc-4b0f-a078-4be1d7f45010";
            position = 3000;

            pins = {
              "Claude" = {
                id = "9b80ed44-b7a2-4dff-adf0-0880d5210125";
                url = "https://claude.ai";
                position = 300;
              };
              "Gemini" = {
                id = "e017461d-b73a-4152-b783-84dd1bd94483";
                url = "https://gemini.google.com/app";
                position = 310;
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
  };
}
