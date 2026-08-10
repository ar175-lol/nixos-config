_: {
  homeManager.kirk = {pkgs, ...}: {
    home = {
      username = "kirk";
      homeDirectory = "/home/kirk";
      stateVersion = "26.11";

      packages = [pkgs.telegram-desktop];
    };
  };
}
