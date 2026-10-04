{ self, inputs, ... }: {

  flake-file.inputs = {
    dank-greeter.url = "github:AvengeMedia/dank-greeter";
  };

  flake.aspects.dms-greeter = configHome: {
    nixos = {
      imports = [
        inputs.dank-greeter.nixosModules.default
      ];

      programs.dms-greeter = {
        inherit configHome;
        enable = true;
      };
    };
    compat.provides = [
      {
        target = self.aspects.niri;
        aspect = {
          nixos = {
            programs.dms-greeter.compositor = {
              name = "niri";
            };
          };
        };
      }
    ];
  };
}
