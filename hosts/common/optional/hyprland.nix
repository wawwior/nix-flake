{ inputs, pkgs, ... }:
let
  pkgs-hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.hyprland = {
    enable = true;
    package = pkgs-hyprland.hyprland;
    portalPackage = pkgs-hyprland.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
    withUWSM = true;
  };
}
