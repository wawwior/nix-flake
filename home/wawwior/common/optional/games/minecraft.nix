{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ferium
    portablemc
  ];
}
