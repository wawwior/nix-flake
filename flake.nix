# Do not modify! This file is generated.

{
  description = "Nix Flake";
  inputs = {
    declarative-flatpak.url = "github:in-a-dil-emma/declarative-flatpak";
    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko";
    };
    flakegen.url = "github:jorsn/flakegen";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-25.05";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    musnix.url = "github:musnix/musnix";
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    stylix.url = "github:wawwior/stylix";
    zen-browser = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:0xc000022070/zen-browser-flake";
    };
  };
  outputs = inputs: inputs.flakegen ./flake.in.nix inputs;
}