_: {
  nixos.victus = {pkgs, ...}: {
    networking.hostName = "victus";

    environment.systemPackages = with pkgs.kdePackages; [
      kdenlive
    ];
    system.stateVersion = "26.05";
  };
}
