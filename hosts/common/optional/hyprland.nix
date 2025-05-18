{ inputs, pkgs, ... }:
let
  hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
  hyprland-pkg = (
    hyprland.hyprland.override {
      # Unused right now
    }
  );
in
{
  programs.hyprland = {
    enable = true;
    package = hyprland-pkg;
    portalPackage = hyprland.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
    withUWSM = true;
  };
  environment.systemPackages = with pkgs; [
    egl-wayland
    xwayland
  ];
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # TODO: Hyprpolkit for 25.05!!
  # security.polkit.package = pkgs.hyprpolkitagent;
}
