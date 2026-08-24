_: {
  perSystem = {
    lib,
    self',
    ...
  }: {
    myNiri.settings.binds =
      {
        "Mod+H".focus-column-left = _: {};
        "Mod+J".focus-window-down = _: {};
        "Mod+K".focus-window-up = _: {};
        "Mod+L".focus-column-right = _: {};

        "Mod+Ctrl+H".move-column-left = _: {};
        "Mod+Ctrl+J".move-window-down = _: {};
        "Mod+Ctrl+K".move-window-up = _: {};
        "Mod+Ctrl+L".move-column-right = _: {};

        "Mod+Space".toggle-window-floating = _: {};
        "Mod+Q".close-window = _: {};
        "Mod+F".maximize-column = _: {};
        "Mod+Grave".toggle-overview = _: {};
        "Mod+Comma".consume-window-into-column = _: {};
        "Mod+Period".expel-window-from-column = _: {};
        "Mod+Return".spawn = lib.getExe self'.packages.myTerminal;
        "Mod+D".spawn-sh = "${lib.getExe self'.packages.myNoctalia} msg panel-toggle launcher";
        "Mod+V".spawn-sh = "${lib.getExe self'.packages.myNoctalia} msg panel-toggle clipboard";

        "Mod+Shift+S".screenshot = _: {};

        "Mod+Slash".show-hotkey-overlay = _: {};
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
