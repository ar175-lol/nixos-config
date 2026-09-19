_: {
  users.ar175.nixos.pc = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.arduino-cli
      pkgs.picocom
    ];

    services.udev.packages = [pkgs.platformio-core.udev];

    users.users.ar175.extraGroups = ["dialout"];
  };
}
