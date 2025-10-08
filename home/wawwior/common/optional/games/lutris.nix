{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lutris
    winetricks
  ];
}
