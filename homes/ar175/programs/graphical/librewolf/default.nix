{
  config,
  inputs,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  homeDirectory = config.home.homeDirectory;
  cfg = osConfig.modules.system.programs.librewolf;
  mkLockedAttrs = builtins.mapAttrs (_: value: {
    Value = value;
    Status = "locked";
  });
in {
  config = lib.mkIf cfg.enable {
    catppuccin = {
      firefox.enable = false;
      librewolf.enable = false;
    };

    programs.librewolf = {
      enable = true;

      settings = {
        "extensions.activeThemeID" = "{76aabc99-c1a8-4c1e-832b-d4f2941d5a7a}";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.uidensity" = 1;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.newtabpage.activity-stream.hideLogo" = true;

        # Fonts
        "browser.display.use_document_fonts" = 1;
        "font.name.serif.x-western" = "JetBrainsMono Nerd Font";
        "font.name.sans-serif.x-western" = "JetBrainsMono Nerd Font";
        "font.name.monospace.x-western" = "JetBrainsMono Nerd Font";

        # Vertical tabs
        "sidebar.verticalTabs" = true;
        "sidebar.position_start" = false;
        "sidebar.visibility" = "expand-on-hover";
        "sidebar.main.tools" = "history,passwords";

        # URL bar
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.quickactions" = false;
        "browser.urlbar.suggest.recentsearches" = false;
        "browser.urlbar.suggest.topsites" = false;

        # Misc
        "layout.frame_rate" = 144;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "mousewheel.default.delta_multiplier_y" = 300;
        "middlemouse.paste" = false;

        # Privacy
        "privacy.resistFingerprinting" = false;
        "privacy.fingerprintingProtection" = true;
        "privacy.spoof_english" = 2;
        "privacy.antitracking.isolateContentScriptResources" = true;
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;

        # DRM
        "media.eme.enabled" = true;
        "media.gmp-widevinecdm.enabled" = true;
      };

      policies = {
        Preferences = mkLockedAttrs {
          "accessibility.force_disabled" = 1;
          "browser.aboutConfig.showWarning" = false;
          "browser.tabs.warnOnClose" = false;
          "browser.tabs.hoverPreview.enabled" = true;
          "browser.gesture.swipe.left" = "";
          "browser.gesture.swipe.right" = "";
          "network.http.referer.XOriginPolicy" = 2;
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;

          # Reduce disk writes
          "browser.cache.disk.enable" = false;
          "browser.sessionstore.interval" = 300000;

          # Smooth scrolling
          "general.autoScroll" = true;
          "general.smoothScroll.msdPhysics.enabled" = true;
          "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
          "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
          "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
          "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
          "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
          "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = "2"; # must be a string
          "general.smoothScroll.currentVelocityWeighting" = "1";
          "general.smoothScroll.stopDecelerationWeighting" = "1";

          "ui.key.menuAccessKeyFocuses" = false;

          # Privacy
          "network.dns.disablePrefetch" = true;
          "network.prefetch-next" = false;
          "security.csp.reporting.enabled" = false;
          "security.tls.enable_0rtt_data" = false;
        };

        # LibreWolf disables EME by default; this overrides it
        EncryptedMediaExtensions = {
          Enabled = true;
          Locked = true;
        };

        SanitizeOnShutdown = {
          Locked = true;
          FormData = true;
          Cache = true;
          History = true;
          Sessions = false;
        };

        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAccounts = true;
        DownloadDirectory = "${homeDirectory}/Downloads";
        RequestedLocales = ["en-US"];
      };

      profiles.default = {
        isDefault = true;

        extensions = {
          force = true;
          packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            ublock-origin
            sponsorblock
            stylus
            catppuccin-mocha-mauve
          ];

          settings = {
            "uBlock0@raymondhill.net".settings = {
              selectedFilterLists = [
                "ublock-filters"
                "ublock-badware"
                "ublock-privacy"
                "ublock-unwrap"
                "ublock-quick-fixes"

                "easylist"
                "easyprivacy"
                "plowe-0"
                "urlhaus-1"

                "RUS-0"
                "RUS-1"

                "ublock-annoyances"
              ];

              netWhitelist = [
                "/aternos\\.(?:org|me)/" # Annoying "You are using an adblocker!"...
              ];
            };
          };
        };

        userChrome = ''
          .tabbrowser-tab .tab-close-button { display: none !important; }
          .tabbrowser-tab:hover .tab-close-button { display: flex !important; }

          * {
            font-family: "JetBrainsMono Nerd Font", monospace !important;
          }
        '';

        userContent = ''
          @-moz-document url-prefix("about:") {
            :root {
              --in-content-page-background: #1e1e2e !important;
              --in-content-page-color: #cdd6f4 !important;
              --in-content-box-background: #313244 !important;
              --in-content-box-border-color: #45475a !important;
              --in-content-table-background: #313244 !important;
              --in-content-primary-button-background: #cba6f7 !important;
              --in-content-primary-button-background-hover: #b4befe !important;
              --in-content-primary-button-text-color: #11111b !important;
              --in-content-link-color: #cba6f7 !important;
            }
          }

          *:not(mat-icon, .material-icons, .material-symbols-outlined, .material-symbols-rounded, .google-symbols, [class*="icon" i], [class*="symbols" i]) {
            font-family: "JetBrainsMono Nerd Font", monospace !important;
          }
        '';
      };
    };
  };
}
