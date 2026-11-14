{lib, ...}: let
  inherit (lib) mkEnableOption mkOption;
in {
  options.modules.system.programs = {
    plasma.enable = mkEnableOption "the KDE Plasma";
    niri.enable = mkEnableOption "the niri compositor";

    greeter = {
      enable = mkEnableOption "the display manager";

      defaultSessions = mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = {};
        description = ''
          Default session per username. Values are matched against the
          greeter's known session commands (for example "niri" or "plasma").
        '';
      };
    };

    noctalia.enable = mkEnableOption "the desktop shell";

    tmux.enable = mkEnableOption "tmux";
    neovim.enable = mkEnableOption "Neovim";

    opencode.enable = mkEnableOption "opencode";

    librewolf.enable = mkEnableOption "LibreWolf";

    drift.enable = mkEnableOption "drift (terminal music player)";
    pwsp.enable = mkEnableOption "PipeWire Soundpad";

    localsend.enable = mkEnableOption "LocalSend";

    kdenlive.enable = mkEnableOption "Kdenlive";
    libreoffice.enable = mkEnableOption "LibreOffice";

    # Gaming profile
    prismlauncher.enable = mkEnableOption "Prism Launcher";
    steam.enable = mkEnableOption "Steam";
    bottles.enable = mkEnableOption "Bottles";
    qbittorrent.enable = mkEnableOption "qBittorrent";

    flatpak.enable = mkEnableOption "Flatpak";

    virtualisation.enable = mkEnableOption "hardware virtualisation (kvm)";
    adb.enable = mkEnableOption "Android debugging bridge";
    printing.enable = mkEnableOption "printing and scanning";
  };
}
