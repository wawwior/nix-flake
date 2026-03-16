{ pkgs, ... }:
{

  home.packages = [
    pkgs.fastfetch
    pkgs.nitch
  ];

  programs.hyfetch = {
    enable = true;
  };
}
