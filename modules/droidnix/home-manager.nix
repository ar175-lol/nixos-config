_: {
  nixOnDroid.modules.base = {
    home-manager = {
      config = {
        home.stateVersion = "24.05";
      };
      backupFileExtension = "hm-bak";
      useGlobalPkgs = true;
    };
  };
}