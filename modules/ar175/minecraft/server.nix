_: {
  users.ar175.nixos.pc = {
    pkgs,
    lib,
    ...
  }: let
    skript = pkgs.fetchurl {
      url = "https://github.com/SkriptLang/Skript/releases/download/2.16.2/Skript-2.16.2.jar";
      hash = "sha256-FM90PuLHzdAUvGOZPJCSll7ew73s/5OuR2Jv3vXSOxA=";
    };
    skbee = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/a0tlbHZO/versions/bTBlzhGZ/SkBee-3.25.4.jar?mr_download_reason=standalone";
      hash = "sha256-RDdDMOhZeMVsxSAiuvOZi3tqqoeu+TU9+GYzbKZ+m4o=";
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

    users.users.ar175.extraGroups = ["minecraft"];

    systemd.services.minecraft-server.preStart = lib.mkAfter ''
      mkdir -p plugins
      cp -f ${skript} plugins/Skript.jar
      cp -f ${skbee} plugins/SkBee.jar
    '';

    # No autostart: the server only runs when started manually with
    #   doas systemctl start minecraft-server
    # Stop it with:
    #   doas systemctl stop minecraft-server
    systemd.services.minecraft-server.wantedBy = lib.mkForce [];
    systemd.sockets.minecraft-server.wantedBy = lib.mkForce [];
  };
}
