{
  flake.aspects.core = { version, ... }: {
    nixos = {
      system.stateVersion = version;
    };
    home = {
      home.stateVersion = version;
    };
  };
}
