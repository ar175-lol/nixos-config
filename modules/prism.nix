{inputs, ...}: {
  flake-file.inputs.prism-launcher.url = "github:ar175-lol/prism-launcher-flake";

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
