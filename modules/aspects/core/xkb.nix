{
  flake.aspects.core = { ... }: {
    nixos = {

      services.xserver = {
        xkb = {
          layout = "de";
          variant = "nodeadkeys";
        };
      };

      console.useXkbConfig = true;
    };
  };
}
