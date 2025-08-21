{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    scarlett2
    alsa-scarlett-gui
  ];

}
