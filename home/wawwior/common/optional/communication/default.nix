{ pkgs, ... }:
{
  home.packages = with pkgs; [
    signal-desktop-source
    vesktop
    element-desktop
  ];
}
