_: {
  users.ar175.nixos.pc = {
    pkgs,
    lib,
    ...
  }: let
    skript = pkgs.fetchurl {
      url = "https://github.com/SkriptLang/Skript/releases/download/2.16.1/Skript-2.16.1.jar";
      hash = "sha256-g1ejSLJ82KLPdJmY5K0UvR3KMWACa9MELW0Xz7TJinA=";
    };
  in {
    services.minecraft-server = {
      enable = true;
      eula = true;
      openFirewall = true;
      declarative = true;
      package = pkgs.papermcServers.papermc-1_21_11;

      serverProperties = {
        server-port = 25565;
        online-mode = false;
        difficulty = 1;
        max-players = 10;
        motd = "My NixOS Paper Server";
      };
    };

    systemd.services.minecraft-server.preStart = lib.mkAfter ''
      mkdir -p plugins
      cp -f ${skript} plugins/Skript.jar
    '';

    # No autostart: the server only runs when started manually with
    #   doas systemctl start minecraft-server
    # Stop it with:
    #   doas systemctl stop minecraft-server
    systemd.services.minecraft-server.wantedBy = lib.mkForce [];
    systemd.sockets.minecraft-server.wantedBy = lib.mkForce [];
  };
}
