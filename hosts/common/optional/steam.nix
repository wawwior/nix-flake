{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  programs.gamemode = {
    enable = true;
    settings = {
      # None needed so far
    };
  };

  users.groups = {
    gamemode = {

    };
  };

  services.udev.packages = [
    pkgs.steamcontroller-udev-rules
  ];
}
