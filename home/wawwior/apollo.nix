{ ... }:
{
  imports = [
    ./common/core
    ./common/optional/sops.nix
    ./common/optional/display
    ./common/optional/browsers/zen.nix
    # ./common/optional/tools
    ./common/optional/gnome-keyring.nix
  ];

  display = {
    name = "DP-1";
    mode = "1920x1080@120";
  };
}
