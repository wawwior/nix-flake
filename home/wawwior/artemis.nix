{ ... }:
{
  imports = [
    ./common/core
    ./common/optional/sops.nix
    ./common/optional/browsers/zen.nix
    ./common/optional/development
    ./common/optional/communication
    ./common/optional/media
    ./common/optional/tools/libreoffice.nix
    # ./common/optional/tools/obsidian.nix
    ./common/optional/tools/files.nix
    ./common/optional/production/audio.nix
    ./common/optional/games
    ./common/optional/gnome-keyring.nix
  ];
}
