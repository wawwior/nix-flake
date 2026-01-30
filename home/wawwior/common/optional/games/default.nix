{ inputs, pkgs, ... }:
{
  imports = [
    ./lutris.nix
    ./minecraft.nix
    ./vintagestory.nix
    # ./nexus.nix
  ];

  home.packages = [
    inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
