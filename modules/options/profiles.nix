{lib, ...}: {
  options.modules.profiles = {
    workstation.enable = lib.mkEnableOption ''
      the Workstation profile

      Everyday desktop software: a browser, an editor, git, the messengers
      and a media suite. This profile says "install the everyday software".
    '';
    gaming.enable = lib.mkEnableOption ''
      the Gaming profile.

      Gaming programs: Steam, qBittorrent, Bottles, and Prism Launcher.
    '';
    laptop.enable = lib.mkEnableOption ''
      the Laptop profile.

      Enables power saving services (power-profiles-daemon, thermald, undervolt) and zram swap.
    '';
    graphical.enable = lib.mkEnableOption ''
      the Graphical profile.

      Desktop environment basics: fish/zsh shells, niri compositor, greeter, noctalia desktop shell, tmux, and portals.
    '';
  };
}
