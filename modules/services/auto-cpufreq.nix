{...}: {
  flake.nixosModules.autocpufreqConfiguration = {...}: {
    services = {
      power-profiles-daemon.enable = false;
      thermald.enable = true;
      auto-cpufreq.enable = true;
      auto-cpufreq.settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };

        charger = {
          governor = "powersave";
          turbo = "never";
        };
      };
    };
  };
}
