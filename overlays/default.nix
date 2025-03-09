{ inputs, ... }:
let

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  rust-overlay = final: prev: inputs.rust-overlay.overlays.default final prev;
in
{
  default =
    final: prev:
    (stable-packages final prev) // (unstable-packages final prev) // (rust-overlay final prev);
}
