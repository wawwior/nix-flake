{ pkgs, lib, ... }:
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
    (lib.hiPrio uutils-coreutils-noprefix)
    fd
    hyperfine
    tokei
    mprocs
  ];
}
