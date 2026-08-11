_: {
  flake-file.inputs = {
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  homeManager.ar175 = {
    inputs,
    pkgs,
    ...
  }: let
    workId = "3e94141e-d73f-44b4-8f28-ac5199d2399c";
    personalId = "534e746a-898e-4284-b874-6c32a5813640";
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
          "theme.custom_uifont.custom" = "JetBrainsMono Nerd Font";
          "theme.custom_uifont.default" = "Custom";
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
          "e74cb40a-f3b8-445a-9826-1b1b6e41b846"
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
          "Work" = {
            id = workId;
            position = 1000;

            pins = {
              "Nix & NixOS" = {
                id = "38e9bfa2-a183-424d-bf85-664e91829a46";
                url = "https://search.nixos.org/options?channel=unstable&type=options";
                position = 151;
                editedTitle = true;
              };
            };
          };
          "Personal" = {
            id = personalId;
            position = 2000;

            pins = {
              "Email" = {
                id = "9cbe689c-65f2-4400-a0ad-5efd052dad4b";
                url = "https://mail.proton.me/u/1/inbox";
                position = 251;
                editedTitle = true;
              };
              "Whatsapp" = {
                id = "e4067f49-45aa-4200-9468-97c7296154f4";
                url = "https://web.whatsapp.com/";
                position = 252;
                editedTitle = true;
              };
            };
          };
        };

        keyboardShortcutsVersion = 20;
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
            id = "zen-copy-url";
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
