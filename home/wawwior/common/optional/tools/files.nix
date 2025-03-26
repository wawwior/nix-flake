{ pkgs, ... }:
{
  home.packages = with pkgs; [
    file-roller
    nautilus
  ];

}
