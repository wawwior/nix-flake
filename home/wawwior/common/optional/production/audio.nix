{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ardour

    distrho-ports
    calf
    # lsp-plugins
    # guitarix
    gxplugins-lv2

    yabridge
    yabridgectl
    wineWow64Packages.stable
  ];
}
