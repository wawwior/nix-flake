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
    ./common/optional/games
    # ./common/optional/tools
    ./common/optional/gnome-keyring.nix
  ];

  display = {
    name = "DP-1";
    mode = "1920x1080@120";
  };
}
