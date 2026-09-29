{ inputs, ... }: {

  flake-file.inputs = {
    dank-greeter.url = "github:AvengeMedia/dank-greeter";
  };

  flake.aspects.dms-greeter = {
    nixos = {
      imports = [
        inputs.dank-greeter.nixosModules.default
      ];

      programs.dms-greeter.enable = true;
    };
  };
}
