{inputs, ...}: {
  flake-file.inputs.nixcord.url = "github:FlameFlag/nixcord";

  users.ar175.home.gui = {pkgs, ...}: {
    imports = [inputs.nixcord.homeModules.default];
    programs.nixcord = {
      enable = true;
      equibop.enable = true;
      # nixpkgs (incl. nixos-unstable) still pins 3.2.2, whose Equicord resolves
      # Discord's modal via findExportedComponentLazy("Modal"). Discord migrated its
      # modal system (Modal moved to @webpack/common), so that lookup now returns
      # null and opening the Go Live screen threw
      # "Cannot read properties of null (reading 'Modal')", killing the renderer.
      equibop.package = let
        base = pkgs.equibop.overrideAttrs (_: {
          version = "3.3.1";
          src = pkgs.fetchFromGitHub {
            owner = "Equicord";
            repo = "Equibop";
            tag = "v3.3.1";
            hash = "sha256-cwRwVdrd91JsOw/WVhPdIJYDwWWhpjlHVhowFlfvoCo=";
          };
        });
      in
        base.overrideAttrs (_: {
          # re-pin the dependency closure hash for 3.3.1.
          #
          # Referenced through "pkgs.equibop.node-modules" rather than
          # 'callPackage "${pkgs.path}/..."'. Interpolating pkgs.path into a
          # string makes the nixpkgs *source* a build input, which is fragile:
          # it resolves to a different store path depending on how nixpkgs was
          # fetched, and "nix flake check" in CI (Determinate Nix) fails with
          #   path '/nix/store/...-nixpkgs-source' is not valid
          # because that source path is not a valid store path in the eval
          # context. node-modules is already an attribute of the equibop
          # package, so there is no reason to import it by path.
          node-modules = pkgs.equibop.node-modules.overrideAttrs (_: {
            equibop = base;
            outputHash = "sha256-odQOJOv3qBYJte5RNF14o33Duxxvm0n5Fy6jfVeCg3I=";
          });
        });
      discord.enable = false;
      config = {
        plugins = {
          consoleJanitor = {
            enable = true;
            disableLoggers = true;
            disableSpotifyLogger = true;
          };
          messageLoggerEnhanced = {
            enable = true;
            cacheMessagesFromServers = true;
            hideMessageFromMessageLoggers = true;
            ignoreBots = true;
            ignoreSelf = true;
            saveImages = true;
            showWhereMessageIsFrom = true;
          };
          autoDndWhilePlaying = {
            enable = true;
            statusToSet = "dnd";
          };
          newGuildSettings = {
            enable = true;
            events = true;
            everyone = true;
          };
          customRpc.enable = true;
          alwaysTrust.enable = true;
          clearUrls.enable = true;
          iRememberYou.enable = true;
          messageNotifier.enable = true;
          neverPausePreviews.enable = true;
          fakeNitro.enable = true;
        };
      };
    };
  };
}
