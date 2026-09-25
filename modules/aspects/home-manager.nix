{ inputs, ... }: {
  flake-file.inputs = {
    home-manager.url = "github:nix-community/home-manager";
  };

  flake.aspects.home-manager = {
    nixos = {
      imports = [ inputs.home-manager.nixosModules.default ];
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
      };
    };
  };
}
