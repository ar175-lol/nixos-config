{lib, ...}: {
  options.modules.profiles = {
    workstation.enable = lib.mkEnableOption ''
      the Workstation profile

      Everyday desktop software: a browser, an editor, git, the messengers
      and a media suite. The role of the same name says "this machine is
      used interactively"; this profile says "install the everyday
      software".
    '';
  };
}
