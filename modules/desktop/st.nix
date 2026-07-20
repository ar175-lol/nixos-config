_: {
  homeManager.ar175 = {pkgs, ...}: {
    home.packages = [
      (pkgs.st.overrideAttrs (oldAttrs: {
        src = ./../../src/st;

        patches = [
          ./../../src/st/patches/st-clipboard-0.8.3.diff
          ./../../src/st/patches/st-scrollback-0.9.2.diff
          ./../../src/st/patches/st-scrollback-mouse-0.9.2.diff
          ./../../src/st/patches/st-scrollback-mouse-altscreen-20220127-2c5edf2.diff
        ];

        postPatch =
          (oldAttrs.postPatch or "")
          + ''
            rm -f config.h

            sed -i 's|static char \*font = .*;|static char *font = "JetBrainsMono Nerd Font:pixelsize=14:antialias=true:autohint=true";|' config.def.h

            sed -i '/static const char \*colorname\[\] = {/,/};/c\
            static const char *colorname[] = {\n\
              "#45475a", "#f38ba8", "#a6e3a1", "#f9e2af",\n\
              "#89b4fa", "#cba6f7", "#94e2d5", "#bac2de",\n\
              "#585b70", "#f38ba8", "#a6e3a1", "#f9e2af",\n\
              "#89b4fa", "#cba6f7", "#94e2d5", "#a6adc8",\n\
              [255] = 0,\n\
              "#1e1e2e", "#cdd6f4", "#cba6f7"\n\
            };' config.def.h

            sed -i 's/unsigned int defaultfg = .*/unsigned int defaultfg = 257;/' config.def.h
            sed -i 's/unsigned int defaultbg = .*/unsigned int defaultbg = 256;/' config.def.h
            sed -i 's/unsigned int defaultcs = .*/unsigned int defaultcs = 258;/' config.def.h
            sed -i 's/static unsigned int defaultrcs = .*/static unsigned int defaultrcs = 257;/' config.def.h
          '';
      }))
    ];
  };
}
