{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ardour
    guitarix
    carla
  ];
}
