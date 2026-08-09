{inputs, ...}: {
  flake-file.inputs.mako-rs.url = "github:ar175-lol/mako-rs";

  homeManager.ar175 = _: {
    imports = [inputs.mako-rs.homeModules.default];

    programs.mako-rs.enable = true;
  };
}
