{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obs-obs-studio
  ];
}
