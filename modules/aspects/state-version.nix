{
  flake.aspects.state-version = version: {
    name = "state-version-${version}";
    nixos = {
      system.stateVersion = version;
    };
    home = {
      home.stateVersion = version;
    };
  };
}
