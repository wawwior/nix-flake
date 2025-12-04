{ ... }:
{
  services.tailscale = {
    enable = true;
  };

  # fixes exit nodes
  networking.firewall.checkReversePath = "loose";
}
