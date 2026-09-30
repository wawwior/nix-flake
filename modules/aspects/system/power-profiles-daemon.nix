{
  flake.aspects.power-profiles-daemon = {
    nixos = {
      services.power-profiles-daemon.enable = true;
    };
  };
}
