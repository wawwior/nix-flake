{ pkgs, ... }:
{
  imports = [
    ./hyprland
    ./wofi.nix
    ./waybar.nix
    ./services/mako.nix
  ];

  home.packages = [
    pkgs.wl-clipboard
  ];
}
