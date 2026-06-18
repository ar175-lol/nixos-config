{
  self,
  inputs,
  ...
}: {
  nixos.desktop = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myKitty
    ];
  };

  perSystem = {pkgs, ...}: {
    packages.myKitty = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;

      font = {
        name = "JetBrainsMono Nerd Font";
        size = 12;
      };

      settings = {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        update_check_interval = 0;

        repaint_delay = 8;
        input_delay = 1;
        sync_to_monitor = true;

        background = "#1d2021";
        foreground = "#ebdbb2";
        selection_background = "#ebdbb2";
        selection_foreground = "#282828";

        cursor = "#a89984";
        cursor_text_color = "#282828";
        cursor_trail = 1;

        confirm_os_window_close = 0;

        color0 = "#282828"; # black
        color8 = "#928374"; # bright black
        color1 = "#cc241d"; # red
        color9 = "#fb4934"; # bright red
        color2 = "#98971a"; # green
        color10 = "#b8bb26"; # bright green
        color3 = "#d79921"; # yellow
        color11 = "#fabd2f"; # bright yellow
        color4 = "#458588"; # blue
        color12 = "#83a598"; # bright blue
        color5 = "#b16286"; # magenta
        color13 = "#d3869b"; # bright magenta
        color6 = "#689d6a"; # cyan
        color14 = "#8ec07c"; # bright cyan
        color7 = "#a89984"; # white
        color15 = "#ebdbb2"; # bright white
      };
    };
  };
}
