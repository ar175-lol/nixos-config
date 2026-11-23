{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.system.programs.greeter;

  sessionCommands = {
    niri = lib.getExe' config.programs.niri.package "niri-session";
    # Match the Exec line from Plasma's own wayland-session desktop file.
    plasma = lib.escapeShellArgs [
      (lib.getExe' pkgs.kdePackages.plasma-workspace "plasma-dbus-run-session-if-needed")
      (lib.getExe' pkgs.kdePackages.plasma-workspace "startplasma-wayland")
    ];
  };

  # What tuigreet would set from the session desktop entries if it launched
  # them directly (DesktopNames and the desktop file's base name).
  sessionEnvironments = {
    niri = {
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_DESKTOP = "niri";
      DESKTOP_SESSION = "niri";
    };
    plasma = {
      XDG_CURRENT_DESKTOP = "KDE";
      XDG_SESSION_DESKTOP = "plasma";
      DESKTOP_SESSION = "plasma";
    };
  };

  # Unknown session names are treated as commands so hosts are not limited to
  # the two entries above.
  sessionCommand = session: sessionCommands.${session} or session;

  sessionEnv = session:
    lib.concatStringsSep "\n" (
      lib.mapAttrsToList (
        key: value: "export ${key}=${lib.escapeShellArg value}"
      ) (sessionEnvironments.${session} or {})
    );

  sessionWrapper = pkgs.writeShellScript "greeter-session" ''
    case "''${USER:-}" in
    ${lib.concatStringsSep "\n" (lib.mapAttrsToList (user: session: ''
        ${lib.escapeShellArg user})
          ${sessionEnv session}
          exec ${sessionCommand session}
          ;;
      '')
      cfg.defaultSessions)}
    *)
        exec ${sessionCommands.niri}
        ;;
    esac
  '';

  # tuigreet can only use the console's 16 ANSI colors, so the palette below
  # (Catppuccin Mocha, with mauve at the magenta slots) is what actually colors
  # the greeter. Keep the theme on ANSI names, not hex.
  theme = lib.concatStringsSep ";" [
    "border=magenta"
    "title=magenta"
    "text=gray"
    "time=magenta"
    "container=black"
    "greet=gray"
    "prompt=magenta"
    "input=white"
    "action=blue"
    "button=magenta"
  ];

  greeterCommand = lib.escapeShellArgs [
    (lib.getExe pkgs.tuigreet)
    "--time"
    "--time-format"
    "%H:%M"
    "--remember"
    "--user-menu"
    "--user-menu-min-uid"
    "1000"
    # Keep the nixbld* build users (UID 30001+) out of the menu.
    "--user-menu-max-uid"
    (toString (config.ids.uids.nixbld - 1))
    "--asterisks"
    "--theme"
    theme
    "--background"
    "doom"
    "--doom-colors"
    "red,yellow,white"
    "--env"
    "XDG_SESSION_TYPE=wayland"
    "--power-shutdown"
    "${config.systemd.package}/bin/loginctl poweroff"
    "--power-reboot"
    "${config.systemd.package}/bin/loginctl reboot"
    "--cmd"
    (toString sessionWrapper)
  ];
in {
  config = lib.mkIf cfg.enable {
    console.useXkbConfig = false;

    # Catppuccin Mocha for the Linux console. Index 5 and 13 use mauve instead
    # of Catppuccin's pink so the greeter accent is mauve.
    console.colors = [
      "1e1e2e" # black (base)
      "f38ba8" # red
      "a6e3a1" # green
      "f9e2af" # yellow
      "89b4fa" # blue
      "cba6f7" # magenta (mauve)
      "94e2d5" # cyan
      "bac2de" # white (subtext1)
      "585b70" # bright black (surface2)
      "f38ba8" # bright red
      "a6e3a1" # bright green
      "f9e2af" # bright yellow
      "89b4fa" # bright blue
      "cba6f7" # bright magenta (mauve)
      "94e2d5" # bright cyan
      "a6adc8" # bright white (subtext0)
    ];

    services.greetd = {
      enable = true;
      useTextGreeter = true;

      settings.default_session = {
        user = "greeter";
        command = greeterCommand;
      };
    };
  };
}
