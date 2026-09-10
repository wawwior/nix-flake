{
  flake.aspects.facter = path: {
    name = "facter";

    nixos = {
      hardware.facter.reportPath = path;
    };
  };
}
