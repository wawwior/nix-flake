{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  environment.systemPackages = with pkgs; [
    limo
    winetricks
    gamescope
    sambaFull
    mangohud
  ];

  programs.gamemode = {
    enable = true;
    settings = {
      # None needed so far
    };
  };

  users.groups = {
    gamemode = { };
  };

}
