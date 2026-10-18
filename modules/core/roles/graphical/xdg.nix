{
  lib,
  config,
  ...
}: let
  homeDir = name: config.users.users.${name}.home or "/home/${name}";
in {
  # XDG directories and mime associations are part of the session, not a
  # choice.
  config.home-manager.users = builtins.listToAttrs (
    map (
      name:
        lib.nameValuePair name {
          xdg = {
            userDirs = {
              enable = true;
              createDirectories = true;

              download = "${homeDir name}/Downloads";
              desktop = "${homeDir name}/Desktop";
              documents = "${homeDir name}/Documents";
              music = "${homeDir name}/Music";
              videos = "${homeDir name}/Videos";
              pictures = "${homeDir name}/Pictures";

              templates = null;
              publicShare = null;
            };
            mimeApps.enable = true;
          };
        }
    )
    config.myUsers.homes
  );
}
