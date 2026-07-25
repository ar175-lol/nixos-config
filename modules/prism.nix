{inputs, ...}: {
  homeManager.ar175 = {pkgs, ...}: {
    imports = [inputs.prism-launcher.homeModules.default];

    programs.prism-launcher = {
      enable = true;

      offline = {
        enable = true;
        username = "ar175";
      };

      jdks = [pkgs.jdk21];
    };
  };
}
