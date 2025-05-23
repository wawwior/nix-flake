{ inputs, ... }:
let

  additions =
    final: prev:
    (prev.lib.packagesFromDirectoryRecursive {
      callPackage = prev.lib.callPackageWith final;
      directory = ../pkgs/common;
    });

  packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config = {
        allowUnfree = true;
      };
    };
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config = {
        allowUnfree = true;
      };
    };
  };

  insecure-packages = final: _prev: {
    insecure = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config = {
        allowUnfree = true;
        allowInsecurePredicate = pkg: true;
      };
    };
  };

in
{
  default =
    final: prev:
    (additions final prev)
    // (packages final prev)
    // (unstable-packages final prev)
    // (insecure-packages final prev);
}
