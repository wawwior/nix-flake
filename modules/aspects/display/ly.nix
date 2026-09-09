{
  flake.aspects.ly = {
    nixos = {
      services.displayManager.ly = {
        enable = true;
      };
    };
  };
}
