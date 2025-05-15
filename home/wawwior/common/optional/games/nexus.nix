{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nexusmods-app-unfree
  ];
}
