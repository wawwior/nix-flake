{
  flake.aspects.tailscale = {
    nixos = {
      services.tailscale.enable = true;
      networking.firewall.checkReversePath = "loose";
    };
  };
}
