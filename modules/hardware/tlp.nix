_: {
  users.ar175.nixos.pc = _: {
    services = {
      power-profiles-daemon.enable = false;
      thermald.enable = false;

      tlp = {
        enable = true;
        settings = {
          # CPU
          CPU_SCALING_GOVERNOR_ON_AC = "powersave";
          CPU_SCALING_GOVERNOR_ON_BAT = "performance";

          CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

          CPU_BOOST_ON_AC = 1;
          CPU_BOOST_ON_BAT = 1;

          CPU_SCALING_MAX_FREQ_ON_BAT = 2500000;
          CPU_SCALING_MAX_FREQ_ON_AC = 2500000;

          CPU_HWP_DYN_BOOST_ON_AC = 0;
          CPU_HWP_DYN_BOOST_ON_BAT = 0;

          # Platform profile
          PLATFORM_PROFILE_ON_AC = "quiet";
          PLATFORM_PROFILE_ON_BAT = "low-power";

          # PCIe
          PCIE_ASPM_ON_AC = "powersupersave";
          PCIE_ASPM_ON_BAT = "powersupersave";

          # WiFi
          WIFI_PWR_ON_AC = "off";
          WIFI_PWR_ON_BAT = "off";

          # USB
          USB_AUTOSUSPEND = 1;
          USB_DENYLIST = "30fa:0300 3151:4015";
          USB_EXCLUDE_BTUSB = 1;
          USB_EXCLUDE_PHONE = 1;

          # Misc
          NMI_WATCHDOG = 0;
        };
      };
    };
  };
}
