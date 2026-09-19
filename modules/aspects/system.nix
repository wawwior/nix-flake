{
  flake.aspects.system = system: {
    name = system;
    nixos = {
      nixpkgs.hostPlatform = system;
    };
  };
}
