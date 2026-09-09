{
  flake.aspects.core = { ... }: {
    nixos = {
      services.openssh.enable = true;
    };
  };
}
