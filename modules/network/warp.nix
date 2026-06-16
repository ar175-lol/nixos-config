_: {
  nixos.victus = {pkgs, ...}: {
    services.cloudflare-warp.enable = true;

    systemd.services.warp-auto-config = {
      description = "Configure Cloudflare WARP in Proxy Mode";

      after = ["cloudflare-warp.service" "network.target"];
      wants = ["cloudflare-warp.service"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };

      script = ''
        ${pkgs.coreutils}/bin/sleep 2

        ${pkgs.cloudflare-warp}/bin/warp-cli --accept-tos tunnel protocol set MASQUE
        ${pkgs.coreutils}/bin/sleep 0.5

        ${pkgs.cloudflare-warp}/bin/warp-cli --accept-tos mode proxy
        ${pkgs.coreutils}/bin/sleep 0.5

        ${pkgs.cloudflare-warp}/bin/warp-cli --accept-tos proxy port 40000
        ${pkgs.coreutils}/bin/sleep 0.5

        ${pkgs.cloudflare-warp}/bin/warp-cli --accept-tos connect
      '';
    };
  };
}
