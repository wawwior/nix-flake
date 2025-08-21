{ pkgs, ... }:
{
  imports = [
    ./helix
    ./intellij.nix
  ];

  home.packages = [
    pkgs.nixd
  ];
}
