{ ... }:
{
  imports = [
    ./common/core
    ./common/optional/sops.nix
    ./common/optional/development
    ./common/optional/communication
    ./common/optional/media
    ./common/optional/games
    ./common/optional/browsers/zen.nix
    ./common/optional/tools/libreoffice.nix
    ./common/optional/tools/files.nix
    ./common/optional/production/audio.nix
    ./common/optional/production/image.nix
    ./common/optional/gnome-keyring.nix
    ./common/optional/blockbench.nix
    # ./common/optional/flatpak.nix
  ];
}
