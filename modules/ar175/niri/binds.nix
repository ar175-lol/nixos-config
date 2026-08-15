_: {
  perSystem = {
    lib,
    self',
    ...
  }: {
    myNiri.settings.binds =
      {
        "Mod+Left".focus-column-left = _: {};
        "Mod+Right".focus-column-right = _: {};
        "Mod+Up".focus-window-up = _: {};
        "Mod+Down".focus-window-down = _: {};
        "Mod+Ctrl+Left".move-column-left = _: {};
        "Mod+Ctrl+Right".move-column-right = _: {};
        "Mod+Ctrl+Down".move-window-down = _: {};
        "Mod+Ctrl+Up".move-window-up = _: {};

        "Mod+H".focus-column-left = _: {};
        "Mod+L".focus-column-right = _: {};
        "Mod+J".focus-window-up = _: {};
        "Mod+K".focus-window-down = _: {};
        "Mod+Ctrl+H".move-column-left = _: {};
        "Mod+Ctrl+L".move-column-right = _: {};
        "Mod+Ctrl+J".move-window-down = _: {};
        "Mod+Ctrl+K".move-window-up = _: {};
        "Mod+Space".toggle-window-floating = _: {};
        "Mod+Q".close-window = _: {};
        "Mod+F".maximize-column = _: {};
        "Mod+Grave".toggle-overview = _: {};

        "Mod+Return".spawn = lib.getExe self'.packages.myFoot;
        "Mod+D".spawn = ["${lib.getExe self'.packages.myRofi}" "-show" "drun"];

        "Mod+Shift+S".screenshot = _: {};
      }
      // (lib.listToAttrs (map (n: {
        name = "Mod+${toString n}";
        value."focus-workspace" = n;
      }) (lib.range 1 9)))
      // (lib.listToAttrs (map (n: {
        name = "Mod+Shift+${toString n}";
        value."move-column-to-workspace" = n;
      }) (lib.range 1 9)));
  };
}
