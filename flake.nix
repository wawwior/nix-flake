# Do not modify! This file is generated.

{
  description = "Nix Flake";
  inputs = {
    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko";
    };
    flakegen.url = "github:jorsn/flakegen";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    hyprland = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hyprwm/Hyprland";
    };
    hytale-launcher.url = "github:TNAZEP/HytaleLauncherFlake";
    minimal-tmux = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:niksingh710/minimal-tmux-status";
    };
    musnix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:musnix/musnix";
    };
    niri = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:sodiboo/niri-flake";
    };
    nix-index-database = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nix-index-database";
    };
    nix-minecraft = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:Infinidoge/nix-minecraft";
    };
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:Mic92/sops-nix";
    };
    stylix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/stylix";
    };
    vicinae.url = "github:vicinaehq/vicinae";
    vicinae-extensions = {
      inputs.vicinae.follows = "vicinae";
      url = "github:vicinaehq/extensions";
    };
    vintagestory-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:PierreBorine/vintagestory-nix";
    };
    zen-browser = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:0xc000022070/zen-browser-flake";
    };
  };
  outputs = inputs: inputs.flakegen ./flake.in.nix inputs;
}