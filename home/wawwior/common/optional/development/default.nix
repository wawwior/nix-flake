{ pkgs, ... }:
{
  imports = [
    ./helix
  ];

  home.packages = [
    pkgs.nixd
  ];
}
