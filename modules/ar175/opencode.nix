{
  users.ar175.nixos.pc = {pkgs, ...}: let
    opencodePatch = pkgs.fetchurl {
      url = "https://github.com/anomalyco/opencode/pull/48397.diff";
      hash = "sha256-MA/qqffbb7vYPTTstjswYs0Wb386nHD1xrSM7aa9v2g=";
    };

    opencodePatched = pkgs.opencode.overrideAttrs (oldAttrs: {
      postPatch =
        (oldAttrs.postPatch or "")
        + ''
          patch -p1 < ${opencodePatch}
        '';
    });
  in {
    environment.systemPackages = [opencodePatched];
  };
}
