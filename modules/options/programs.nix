# The program surface. Every module under modules/system/programs implements
# one option declared here, and everything defaults to off: profiles flip
# bundles, roles flip what the machine implies, and a host can still flip a
# single one back.
{lib, ...}: let
  inherit (lib) mkEnableOption mkOption types;
in {
  options.modules.system.programs = {
    # --- desktop session ---------------------------------------------------
    niri.enable = mkEnableOption "the niri compositor";
    greeter.enable = mkEnableOption "the Noctalia display manager";
    noctalia.enable = mkEnableOption "the Noctalia desktop shell";

    # --- terminals and prompts ---------------------------------------------
    tmux.enable = mkEnableOption "tmux";
    starship.enable = mkEnableOption "the starship prompt";

    # --- browsers and editors ----------------------------------------------
    browser.enable = mkEnableOption "Zen Browser";
    neovim.enable = mkEnableOption "Neovim";

    # --- development --------------------------------------------------------
    git.enable = mkEnableOption "git, with your identity";
    direnv.enable = mkEnableOption "direnv, with nix-direnv and devenv";
    nh.enable = mkEnableOption "nh, pointed at your config";
    opencode.enable = mkEnableOption "opencode";

    # --- communication ------------------------------------------------------
    discord.enable = mkEnableOption "Discord";
    telegram.enable = mkEnableOption "Telegram";

    # --- media --------------------------------------------------------------
    obs.enable = mkEnableOption "OBS Studio";
    kdenlive.enable = mkEnableOption "Kdenlive";
    libreoffice.enable = mkEnableOption "LibreOffice";

    # --- games --------------------------------------------------------------
    gaming.enable = mkEnableOption "Steam, Bottles and qBittorrent";

    minecraft = {
      enable = mkEnableOption "Minecraft, via Prism Launcher";
      offlineUsername = mkOption {
        type = types.str;
        default = "Player";
        description = "The offline-mode username Prism Launcher starts with.";
      };
    };

    # --- system plumbing ----------------------------------------------------
    virtualisation.enable = mkEnableOption "hardware virtualisation (kvm)";
    adb.enable = mkEnableOption "Android debugging bridge";
    printing.enable = mkEnableOption "printing and scanning";
    ncalayer.enable = mkEnableOption "ncalayer network manager";
  };
}
