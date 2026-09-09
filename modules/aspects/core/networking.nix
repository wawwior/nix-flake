{
  flake.aspects.core = { name, ... }: {
    nixos = {
      networking.hostName = name;
    };
  };
}
