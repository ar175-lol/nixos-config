_: {
  nixos.victus = {pkgs, ...}: {
    services.cloudflare-warp.enable = true;

    environment.etc."xdg/autostart/cloudflare-warp-gui.desktop".text = "";
    environment.etc."xdg/autostart/warp-gui.desktop".text = "";

    systemd.services.cloudflare-warp.serviceConfig.LogLevelMax = "warning";

    systemd.services.warp-auto-config = {
      description = "Configure Cloudflare WARP in Proxy Mode";

      after = ["warp-svc.service" "network.target"];
      wants = ["cloudflare-warp.service"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };

      script = ''
        ${pkgs.coreutils}/bin/sleep 1

        ${pkgs.cloudflare-warp}/bin/warp-cli --accept-tos tunnel protocol set MASQUE
        ${pkgs.cloudflare-warp}/bin/warp-cli --accept-tos mode proxy
        ${pkgs.cloudflare-warp}/bin/warp-cli --accept-tos proxy port 40000
        ${pkgs.cloudflare-warp}/bin/warp-cli --accept-tos connect
      '';
    };
  };
}
