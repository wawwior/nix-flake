{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans";
      fontSize = "9";
    })
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
    package = pkgs.kdePackages.sddm;
    theme = "catppuccin-mocha";
  };
}
