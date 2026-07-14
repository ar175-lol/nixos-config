_: {
  # Why I am keeping this file?
  nixos.home = _: {
    # imports = [inputs.nixcord.homeModules.default];
    #
    # programs.nixcord = {
    #   enable = false;
    #   equibop.enable = true;
    #   discord.enable = false;
    #
    #   config = {
    #     plugins = {
    #       consoleJanitor = {
    #         enable = true;
    #         disableLoggers = true;
    #         disableSpotifyLogger = true;
    #       };
    #
    #       messageLoggerEnhanced = {
    #         enable = true;
    #         cacheMessagesFromServers = true;
    #         hideMessageFromMessageLoggers = true;
    #         ignoreBots = true;
    #         ignoreSelf = true;
    #         saveImages = true;
    #         showWhereMessageIsFrom = true;
    #       };
    #
    #       autoDndWhilePlaying = {
    #         enable = true;
    #         statusToSet = "dnd";
    #       };
    #
    #       newGuildSettings = {
    #         enable = true;
    #         events = true;
    #         everyone = true;
    #       };
    #
    #       customRpc.enable = true;
    #       alwaysTrust.enable = true;
    #       clearUrls.enable = true;
    #       iRememberYou.enable = true;
    #       messageNotifier.enable = true;
    #       neverPausePreviews.enable = true;
    #       fakeNitro.enable = true;
    #     };
    #   };
  };
  # };
}
