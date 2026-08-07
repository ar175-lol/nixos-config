_: {
  nixos.victus = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      android-tools
    ];
  };
}
