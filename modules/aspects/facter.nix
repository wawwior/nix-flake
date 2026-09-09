{
  flake.aspects.facter = path: {
    nixos = {
      hardware.facter.reportPath = path;
    };
  };
}
