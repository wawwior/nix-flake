{ self, inputs, ... }: {

  flake-file.inputs = {
    dux-greeter.url = "github:duxlabs-dev/dux-greeter";
  };

  flake.aspects.dux-greeter = configHome: {
    nixos = {
      imports = [
        inputs.dux-greeter.nixosModules.default
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
