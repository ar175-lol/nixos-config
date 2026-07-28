_: {
  homeManager.ar175 = {
    inputs,
    pkgs,
    ...
  }: let
    mkRouting = {
      url,
      openIn,
    }: {
      reference = url;
      matchType = "contains";
      inherit openIn;
    };

    workId = "3e94141e-d73f-44b4-8f28-ac5199d2399c";
  in {
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

        extensions = {
          force = true;
          packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            ublock-origin
            sponsorblock
          ];

          settings = {
            "uBlock0@raymondhill.net".settings = {
              selectedFilterLists = [
                "ublock-filters"
                "ublock-badware"
                "ublock-privacy"
                "ublock-unbreak"
                "ublock-quick-fixes"

                "easylist"
                "easyprivacy"
                "plowe-0"
                "urlhaus-1"

                "RUS-0"
                "RUS-1"

                "ublock-annoyances"
              ];
            };
          };
        };

        mods = [
          "1b88a6d1-d931-45e8-b6c3-bfdca2c7e9d6"
          "253a3a74-0cc4-47b7-8b82-996a64f030d5"
          "b51ff956-6aea-47ab-80c7-d6c047c0d510"
          "f4866f39-cfd6-4498-ab92-54213b8279dc"
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

        spaceRouting = {
          routes = {
            "github.com" = mkRouting {
              url = "github.com";
              openIn = workId;
            };
            "gitlab.com" = mkRouting {
              url = "gitlab.com";
              openIn = workId;
            };
          };
        };

        spacesForce = true;
        spaces = {
          "Work" = {
            id = workId;
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

            pins = {
              "Nix & NixOS" = {
                id = "38e9bfa2-a183-424d-bf85-664e91829a46";
                url = "https://search.nixos.org/options?channel=unstable&type=options";
                position = 170;
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
