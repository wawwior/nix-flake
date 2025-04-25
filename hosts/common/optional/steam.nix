{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  environment.systemPackages = with pkgs; [ limo ];

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
