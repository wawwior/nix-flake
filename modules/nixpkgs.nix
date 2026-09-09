{
  withSystem,
  inputs,
  config,
  lib,
  ...
}:
{

  options.nixpkgs.overlays = lib.mkOption {
    type = with lib.types; listOf raw;
    default = [ ];
    description = "global nixpkgs overlays";
  };

  config = {
    flake-file.inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    perSystem = { system, ... }: {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = config.nixpkgs.overlays;
      };
    };

    flake.aspects.core = { ... }: {
      nixos = { config, ... }: {
        nixpkgs.pkgs = withSystem config.nixpkgs.hostPlatform.system ({ pkgs, ... }: pkgs);
      };
    };
  };

}
