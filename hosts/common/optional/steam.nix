{ pkgs, ... }:
{
  programs.steam.enable = true;
  services.udev.packages = [
    pkgs.steamcontroller-udev-rules
  ];
}
