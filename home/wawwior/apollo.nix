{ ... }:
{
  imports = [
    ./common/core
    ./common/optional/sops.nix
    ./common/optional/display
    ./common/optional/browsers/zen.nix
    ./common/optional/tools
    ./common/optional/gnome-keyring.nix
  ];
}
