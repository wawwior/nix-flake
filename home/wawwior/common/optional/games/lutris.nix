{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # bottles
    winetricks
    protontricks
    # umu-launcher
  ];
}
