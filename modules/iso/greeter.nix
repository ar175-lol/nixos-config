{self, ...}: {
  users.nixos.nixos.base = {pkgs, ...}: {
    services = {
      displayManager.autoLogin = {
        enable = true;
        user = "nixos";
      };
      greetd = {
        enable = true;
        settings.default_session = {
          command = "${pkgs.dbus}/bin/dbus-run-session ${self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri}/bin/niri --session";
          user = "nixos";
        };
      };
    };

    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };
}
