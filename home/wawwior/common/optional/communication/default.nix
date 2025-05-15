{ pkgs, ... }:
{
  home.packages = with pkgs; [
    signal-desktop
    vesktop
    element-desktop
  ];
}
