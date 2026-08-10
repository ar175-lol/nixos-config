_: {
  homeManager.kirk = {
    pkgs,
    lib,
    ...
  }: {
    home = {
      username = lib.mkForce "kirk";
      homeDirectory = lib.mkForce "/home/kirk";
      stateVersion = "26.11";

      packages = [pkgs.telegram-desktop];
    };
  };
}
