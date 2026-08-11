_: {
  nixos.victus = {pkgs, ...}: {
    networking.hostName = "victus";

    sops.age.sshKeyPaths = [ "/home/ar175/.ssh/id_ed25519" ];

    environment.systemPackages = with pkgs; [
      kdePackages.kdenlive
      codex
    ];
    system.stateVersion = "26.05";
  };
}
