{ ... }:
{
  imports = [
    ./common/core
    ./common/optional/sops.nix
    ./common/optional/display
    ./common/optional/development
    ./common/optional/communication
    ./common/optional/media
    ./common/optional/games
    ./common/optional/browsers/zen.nix
    ./common/optional/tools/libreoffice.nix
    ./common/optional/tools/obsidian.nix
    ./common/optional/tools/files.nix
    ./common/optional/production/audio.nix
    ./common/optional/gnome-keyring.nix
    # ./common/optional/flatpak.nix
  ];

  display = {
    name = "DP-3";
    mode = "1920x1080@119.98";
  };
}
