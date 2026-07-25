{inputs, ...}: {
  homeManager.ar175 = _: {
    imports = [inputs.mako-rs.homeModules.default];

    programs.mako-rs.enable = true;
  };
}
