_: {
  users.kirk.home.base = {pkgs, ...}: {
    home.packages = [pkgs.telegram-desktop];
  };
}
