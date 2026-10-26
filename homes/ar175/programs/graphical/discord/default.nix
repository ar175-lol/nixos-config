{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nixcord.homeModules.default];

  programs.nixcord = {
    enable = true;
    equibop.enable = true;

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
        node-modules =
          (
            inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.callPackage
            "${inputs.nixpkgs}/pkgs/by-name/eq/equibop/node-modules.nix"
            {
              equibop = base;
            }
          )
              .overrideAttrs (_: {
            outputHash = "sha256-odQOJOv3qBYJte5RNF14o33Duxxvm0n5Fy6jfVeCg3I=";
          });
      });

    discord.enable = false;

    config.plugins = {
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
}
