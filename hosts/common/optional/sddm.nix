{ pkgs, ... }:
{

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
    package = pkgs.kdePackages.sddm;
  };
}
