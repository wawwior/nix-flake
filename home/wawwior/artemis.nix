{ ... }:
{
  imports = [
    ./common/core
    ./common/optional/sops.nix
    ./common/optional/display
    ./common/optional/browsers/zen.nix
    ./common/optional/development
    ./common/optional/communication
    ./common/optional/media
    ./common/optional/tools
    ./common/optional/games
    ./common/optional/gnome-keyring.nix
  ];

  display = {
    name = "eDP-1";
    scale = 1.25;
  };
}
