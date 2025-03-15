{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    inputs.zen-browser.packages.${system}.default
  ];
  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "zen.desktop" ];
    "text/xml" = [ "zen.desktop" ];
    "x-scheme-handler/http" = [ "zen.desktop" ];
  };
}
