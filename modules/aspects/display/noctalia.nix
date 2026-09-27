{ inputs, ... }: {
  flake-file.inputs = {
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.aspects.noctalia = {
    nixos = {
      imports = [ inputs.noctalia.nixosModules.default ];
      programs.noctalia.enable = true;
    };

    home = {
      imports = [ inputs.noctalia.homeModules.default ];
      programs.noctalia = {
        enable = true;
        settings = {

        };
      };
    };
  };
}
