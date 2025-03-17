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

    kernelPackages = pkgs.linuxPackages_6_12;
  };
}
