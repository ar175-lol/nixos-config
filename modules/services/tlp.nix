_: {
  nixos.laptop = _: {
    services = {
      power-profiles-daemon.enable = false;
      thermald.enable = false;

      tlp = {
        enable = true;
        settings = {
          # CPU
          CPU_SCALING_GOVERNOR_ON_AC = "powersave";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
          CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
          CPU_BOOST_ON_AC = 0;
          CPU_BOOST_ON_BAT = 0;

          # Platform profile
          PLATFORM_PROFILE_ON_AC = "balanced";
          PLATFORM_PROFILE_ON_BAT = "balanced";

          # PCIe
          PCIE_ASPM_ON_AC = "default";
          PCIE_ASPM_ON_BAT = "default";

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
