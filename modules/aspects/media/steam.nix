{
  flake.aspects.steam = {
    nixos = {
      programs.steam.enable = true;
    };
  };
}
