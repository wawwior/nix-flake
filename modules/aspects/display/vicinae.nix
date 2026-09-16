{ inputs, ... }: {

  flake-file.inputs = {
    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs = {
        vicinae.follows = "vicinae";
        nixpkgs.follows = "vicinae/nixpkgs";
        systems.follows = "vicinae/systems";
      };
    };
  };

  nixpkgs.overlays = [
    inputs.vicinae.overlays.default
    (final: prev: {
      vicinae-extensions = inputs.vicinae-extensions.packages.${final.stdenv.hostPlatform.system};
    })
  ];

  flake.aspects.vicinae = {
    nixos = {
      imports = [
        inputs.vicinae.nixosModules.default
      ];
    };
    home = { pkgs, ... }: {
      imports = [
        inputs.vicinae.homeManagerModules.default
      ];

      capabilities.commands.launcher = "vicinae toggle";

      programs.vicinae = {
        enable = true;
        systemd = {
          enable = true;
          environment = {
            USE_LAYER_SHELL = 1;
          };
        };
        settings = {
          theme = {
            dark = {
              name = "stylix";
            };
          };
          launcher_window = {
            opacity = 1.0;
          };
        };
        extensions = with pkgs.vicinae-extensions; [
          nix
          # TODO: PR
          # bluetooth
          pulseaudio
          power-profile
        ];
      };

      home.packages = [
        pkgs.pulseaudio
      ];
    };
  };
}
