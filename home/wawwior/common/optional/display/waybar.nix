{ lib, ... }:
{

  programs.waybar = {
    systemd.enable = true;
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 36;

        modules-left = [ "clock" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
          "tray"
          "wireplumber"
          "memory"
          "cpu"
          "temperature"
          "battery"
        ];

        temperature = {
          hwmon-path-abs = "/sys/devices/platform/coretemp.0/hwmon";
          input-filename = "temp1_input";
          format = "{temperatureC}°C";
        };
      }
    ];
    style = lib.mkAfter ''
      /* css */
        * {
          font-family: "DejaVuSansM Nerd Font Mono";
          font-size: 13px;
        }
    '';
  };
}
