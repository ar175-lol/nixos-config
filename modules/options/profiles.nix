{lib, ...}: {
  options.modules.profiles = {
    workstation.enable = lib.mkEnableOption ''
      the Workstation profile

      Everyday desktop software: a browser, an editor, git, the messengers
      and a media suite. The role of the same name says "this machine is
      used interactively"; this profile says "install the everyday
      software".
    '';
    gaming = {
      enable = lib.mkEnableOption "the Gaming profile";
      steam.enable = lib.mkEnableOption "Steam";
      qbittorrent.enable = lib.mkEnableOption "qBittorrent";
      bottles.enable = lib.mkEnableOption "Bottles";
      minecraft.enable = lib.mkEnableOption "Prism Launcher";
    };
  };
}
