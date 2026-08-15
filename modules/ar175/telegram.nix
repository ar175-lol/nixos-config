_: {
  users.ar175.home.base = {pkgs, ...}: {
    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    home.packages = [pkgs.telegram-desktop];
  };
}
