{
  self,
  inputs,
  ...
}: {
  nixos.desktop = {pkgs, ...}: {
    programs.waybar = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myWaybar;
    };
  };

  perSystem = {pkgs, ...}: {
    packages.myWaybar = inputs.wrapper-modules.wrappers.waybar.wrap {
      inherit pkgs;

      settings = {
        layer = "top";
        position = "top";
        height = 8;
        spacing = 7;
        modules-left = [
          "clock"
        ];
        modules-center = [
          "niri/workspaces"
        ];
        modules-right = [
          "niri/language"
          # "network"
          "memory"
          "pulseaudio"
          "bluetooth"
          # "battery"
          "custom/battery"
          "tray"
        ];

        "niri/workspaces" = {
          format = "{index}";
        };

        clock = {
          format = "{:%H:%M}";
          tooltip = false;
        };

        network = {
          format-wifi = "";
          format-ethernet = "󰊗";
          format-linked = "󰊗";
          format-disconnected = "󱛅";
          tooltip = false;
        };

        "niri/language" = {
          format = "{}";
          format-en = "US";
          format-ru = "RU";
          tooltip = false;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰖁";
          format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          scroll-step = 3;
          tooltip = false;
        };

        bluetooth = {
          interval = 1;
          format-on = "󰂯";
          format-off = "󰂲";
          format-disabled = "󰂲";
          format-connected = "󰂱";
          format-connected-battery = "󰂯 {device_battery_percentage}%";
          tooltip-format-connected = "{num_connections} connected\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };

        cpu = {
          interval = 3;
          format = "  {icon} {usage:>2}%";
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          on-click = "foot -e btop";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        memory = {
          interval = 5;
          format = "  {}%";
          on-click = "$TERMINAL -e btop";
          states = {
            cool = 50;
            warning = 70;
            critical = 90;
          };
        };

        "custom/battery" = {
          exec = "${./../assets/custom-battery}";
          return-type = "json";
        };

        battery = {
          interval = 5;
          states = {
            warning = 30;
            critical = 15;
          };
          format-discharging = "{icon} {capacity}% {time}";
          format-charging = "{icon} {capacity}% {time}";
          format-not-charging = "{icon} {capacity}% {time}";
          format-plugged = "{icon} {capacity}%";
          format-full = "󰁹";
          format-time = "{H}h{M:2}m";
          format-icons = [
            "󰂎"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁿"
            "󰂁"
            "󰁹"
          ];
        };
        tray = {
          icon-size = 16;
          spacing = 10;
        };
      };

      "style.css" = {
        content = builtins.readFile ./style.css;
      };
    };
  };
}
