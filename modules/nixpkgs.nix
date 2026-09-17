{

  flake-file.inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
  };

}
