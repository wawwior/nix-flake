{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ardour
    guitarix

    distrho-ports
    calf
    # lsp-plugins
    # guitarix
    gxplugins-lv2

    yabridge
    yabridgectl
    wineWowPackages.stable
  ];
}
