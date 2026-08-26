{
  config_version = 13;

  bar.default = {
    center = ["group:g3" "group:g4"];
    end = ["audio_visualizer" "keyboard_layout" "group:g2"];
    font_family = "JetBrainsMono NF";
    font_weight = 700;
    margin_edge = 0;
    margin_ends = 0;
    position = "left";
    radius = 22;
    radius_bottom_left = 0;
    radius_top_left = 0;
    radius_top_right = 22;
    scale = 1.5000000149011612;
    start = ["launcher_nixos" "workspaces"];
    thickness = 40;

    capsule_group = [
      {
        accordion = false;
        accordion_direction = "end";
        enabled = true;
        fill = "surface_variant";
        id = "g2";
        members = ["network" "battery" "volume" "session"];
        opacity = 1.0;
        padding = 6.0;
      }
      {
        accordion = false;
        accordion_direction = "end";
        enabled = true;
        fill = "surface_variant";
        id = "g3";
        members = ["clock_icon" "clock"];
        opacity = 1.0;
        padding = 6.0;
      }
      {
        accordion = false;
        accordion_direction = "start";
        enabled = true;
        fill = "surface_variant";
        id = "g4";
        members = ["date_icon" "date"];
        opacity = 1.0;
        padding = 6.0;
      }
    ];
  };

  control_center.shortcuts = [
    {type = "wifi";}
    {type = "bluetooth";}
    {type = "nightlight";}
    {type = "notification";}
  ];

  dock = {
    reserve_space = false;
    show_dots = true;
    smart_auto_hide = true;
  };

  lockscreen.blurred_desktop = true;

  lockscreen_widgets = {
    enabled = true;
    schema_version = 2;
    widget_order = ["lockscreen-login-box@winit" "lockscreen-login-box@eDP-1" "lockscreen-widget-0000000000000001"];

    grid = {
      cell_size = 8;
      major_interval = 4;
      visible = true;
    };

    widget = {
      "lockscreen-login-box@eDP-1" = {
        box_height = 196.0;
        box_width = 720.0;
        cx = 960.0;
        cy = 550.0;
        output = "eDP-1";
        placement_height = 1080.0;
        placement_width = 1920.0;
        rotation = 0.0;
        type = "login_box";

        settings = {
          background_color = "surface_variant";
          background_opacity = 0.88;
          background_radius = 12.0;
          center_password_text = false;
          input_opacity = 1.0;
          input_radius = 6.0;
          layout = "regular";
          show_caps_lock = true;
          show_keyboard_layout = true;
          show_login_button = true;
          show_media = true;
          show_session_buttons = true;
          show_unlock_hint = true;
          show_weather = true;
        };
      };

      "lockscreen-login-box@winit" = {
        box_height = 196.0;
        box_width = 810.0;
        cx = 937.00323486328125;
        cy = 890.0;
        output = "winit";
        placement_height = 1072.0;
        placement_width = 1872.0;
        rotation = 0.0;
        type = "login_box";

        settings = {
          background_color = "surface_variant";
          background_opacity = 0.88;
          background_radius = 12.0;
          center_password_text = false;
          input_opacity = 1.0;
          input_radius = 6.0;
          layout = "regular";
          show_caps_lock = true;
          show_keyboard_layout = true;
          show_login_button = true;
          show_media = true;
          show_session_buttons = true;
          show_unlock_hint = true;
          show_weather = true;
        };
      };

      lockscreen-widget-0000000000000001 = {
        box_height = 96.0;
        box_width = 784.0;
        cx = 960.0;
        cy = 308.0;
        output = "eDP-1";
        placement_height = 1080.0;
        placement_width = 1920.0;
        rotation = 0.0;
        type = "clock";
      };
    };
  };

  nightlight = {
    enabled = true;
    force = true;
    temperature_day = 5000;
    temperature_night = 5000;
  };

  notification.history_retention_hours = 2;

  osd = {
    position = "top_right";
    position_vertical = "top_right";

    kinds = {
      keyboard_layout = false;
      media = false;
      power_profile = false;
      privacy = false;
    };
  };

  plugin_settings."thepunkoff/pomodoro" = {
    auto-start-breaks = true;
    auto-start-work = true;
    long-break-duration = 1;
    short-break-duration = 1;
    work-duration = 19;
  };

  plugins.enabled = [];

  shell = {
    font_family = "JetBrainsMono NF SemiBold";
    password_style = "random";

    animation.speed = 0.5000000074505806;

    launcher.show_app_origin_indicator = false;

    launcher.providers = {
      calculator = {
        global = true;
        prefix = ">calc";
      };
      emoji = {
        prefix = ">emoji";
      };
    };

    panel = {
      control_center_placement = "floating";
      floating_offset = 7;
      open_near_click_control_center = true;
      session_placement = "floating";
      session_position = "center";
    };

    session.show_shortcuts = false;
  };

  theme = {
    builtin = "Catppuccin";
    community_palette = "Catppuccin Mocha Mauve-Lavender";
    mode = "dark";
    source = "community";
    wallpaper_scheme = "m3-tonal-spot";

    templates = {
      enable_builtin_templates = false;
      enable_community_templates = false;
    };
  };

  wallpaper = {
    directory = "/home/ar175/nixos-config/modules/ar175/assets";
    transition_on_startup = true;

    default.path = "/home/ar175/nixos-config/modules/ar175/assets/wall4.png";
    last.path = "/home/ar175/nixos-config/modules/ar175/assets/wall4.png";
    monitors.eDP-1.path = "/home/ar175/nixos-config/modules/ar175/assets/wall4.png";

    favorite = [
      {
        builtin_palette = "Catppuccin";
        palette_source = "builtin";
        path = "/home/ar175/nixos-config/modules/ar175/assets/wall4.png";
        theme_mode = "dark";
      }
    ];
  };

  widget = {
    active_window = {
      display = "icon_only";
    };

    audio_visualizer = {
      bands = 12;
      width = 48;
    };

    battery = {
      capsule = true;
      display_mode = "graphic";
      scale = 0.90000000000000013;
      show_label = false;
    };

    clock = {
      capsule = true;
      font_family = "JetBrainsMono NF";
      font_weight = 700;
      format = ''
        {:%H %M}'';
      scale = 0.80000000000000004;
      vertical_format = "{:%H %M}";
    };

    clock_icon = {
      glyph = "clock-filled";
      interactive = false;
      scale = 0.85000000000000009;
      type = "custom_button";
    };

    control-center = {
      capsule = true;
      glyph = "user";
      scale = 0.80000000000000004;
    };

    date = {
      capsule = true;
      format = "{:%d %m}";
      scale = 0.80000000000000004;
    };

    date_icon = {
      glyph = "calendar-month";
      interactive = false;
      scale = 0.85000000000000009;
      type = "custom_button";
    };

    keyboard_layout = {
      capsule = true;
      capsule_radius = "auto";
      font_weight = 700;
      scale = 0.75;
    };

    launcher_nixos = {
      custom_image = "/home/ar175/Downloads/NixOS.png";
      custom_image_colorize = true;
      type = "custom_button";
    };

    network = {
      scale = 0.90000000000000013;
      show_label = false;
    };

    session = {
      scale = 0.90000000000000013;
    };

    volume = {
      capsule = true;
      capsule_padding = 8;
      scale = 0.90000000000000013;
      show_label = false;
    };

    workspaces = {
      active_pill_size = 2.3999999999999999;
      capsule = true;
      capsule_radius = "auto";
      font_weight = 700;
      labels_only_when_occupied = true;
      occupied_color = "tertiary";
      scale = 0.80000000000000004;
      show_labels = false;
    };
  };
}
