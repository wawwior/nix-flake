{ pkgs, ... }:
{
  boot = {
    kernelPatches = [
      {
        name = "Rust Support";
        patch = null;
        features = {
          rust = true;
        };
      }
    ];
  };
}
