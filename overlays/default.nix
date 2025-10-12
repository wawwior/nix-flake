{ inputs, ... }:
let

  additions =
    final: prev:
    (prev.lib.packagesFromDirectoryRecursive {
      callPackage = prev.lib.callPackageWith final;
      directory = ../pkgs/common;
    });

  unfree-stable-packages-insecure = final: _prev: {
    stable =
      import inputs.nixpkgs-stable {
        inherit (final) system;
        config = {
          allowUnfree = true;
        };
      }
      // {
        insecure = import inputs.nixpkgs-stable {
          inherit (final) system;
          config = {
            allowUnfree = true;
            allowInsecurePredicate = pkgs: true;
          };
        };
      };
  };

  unfree-unstable-packages-insecure = final: _prev: {
    unstable =
      import inputs.nixpkgs-unstable {
        inherit (final) system;
        config = {
          allowUnfree = true;
        };
      }
      // {
        insecure = import inputs.nixpkgs-unstable {
          inherit (final) system;
          config = {
            allowUnfree = true;
            allowInsecurePredicate = pkgs: true;
          };
        };
      };
  };

  unfree-stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config = {
        allowUnfree = true;
      };
    };
  };

  unfree-unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config = {
        allowUnfree = true;
      };
    };
  };

  stable-packages-insecure = final: _prev: {
    stable =
      import inputs.nixpkgs-stable {
        inherit (final) system;
      }
      // {
        insecure = import inputs.nixpkgs-stable {
          inherit (final) system;
          config = {
            allowInsecurePredicate = pkgs: true;
          };
        };
      };
  };

  unstable-packages-insecure = final: _prev: {
    unstable =
      import inputs.nixpkgs-unstable {
        inherit (final) system;
      }
      // {
        insecure = import inputs.nixpkgs-unstable {
          inherit (final) system;
          config = {
            allowInsecurePredicate = pkgs: true;
          };
        };
      };
  };

  packages-insecure = final: _prev: {
    insecure = import inputs.nixpkgs {
      inherit (final) system;
      config = {
        allowInsecurePredicate = pkg: true;
      };
    };
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
    };
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
    };
  };

in
{
  unfree-insecure =
    final: prev:
    (additions final prev)
    // (packages-insecure final prev)
    // (unfree-stable-packages-insecure final prev)
    // (unfree-unstable-packages-insecure final prev)
    // (inputs.vintagestory-nix.overlays.default final prev);

  unfree =
    final: prev:
    (additions final prev)
    // (unfree-stable-packages final prev)
    // (unfree-unstable-packages final prev);

  insecure =
    final: prev:
    (additions final prev)
    // (packages-insecure final prev)
    // (stable-packages-insecure final prev)
    // (unstable-packages-insecure final prev);

  default = final: prev: (stable-packages final prev) // (unstable-packages final prev);
}
