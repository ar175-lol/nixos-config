_: {
  perSystem = _: {
    myNiri.debug = {
      render-drm-device = "/dev/dri/by-path/pci-0000:00:02.0-render";
      ignore-drm-device = "/dev/dri/by-path/pci-0000:01:00.0-render";
    };
  };
}
