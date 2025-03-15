{ pkgs, ... }:
{

  imports = [
    ./yazi.nix
    ./hyfetch.nix
    ./bat.nix
    ./lazygit.nix
    ./btop.nix
  ];

  home.packages = with pkgs; [
    ripgrep
    eza
    nvtopPackages.full
  ];
}
