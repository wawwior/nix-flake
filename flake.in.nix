{
  description = "Nix Flake";

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let

      inherit (self) outputs;
      inherit (nixpkgs) lib;

      lix = inputs.lix-module;

      mkHost = host: {
        ${host} = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hosts/nixos/${host}
            # lix.nixosModules.default
          ];

          lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });
        };
      };

      mkHostConfigs = hosts: lib.foldl (acc: set: acc // set) { } (lib.map (host: mkHost host) hosts);

      hosts = lib.attrNames (builtins.readDir ./hosts/nixos);

    in
    {
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = mkHostConfigs hosts;
    };

  inputs =
    let
      unstable = true;
      hyprland_pin = false;
    in
    rec {

      nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

      nixpkgs = if unstable then nixpkgs-unstable else nixpkgs-stable;

      lix-module = {
        url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nixos-facter-modules.url = "github:numtide/nixos-facter-modules";

      disko = {
        url = "github:nix-community/disko";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      home-manager = {
        url = "github:nix-community/home-manager" + (if unstable then "" else "/release-24.11");
        inputs.nixpkgs.follows = "nixpkgs";
      };

      sops-nix.url = "github:Mic92/sops-nix";

      rust-overlay = {
        url = "github:oxalica/rust-overlay";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      stylix.url = if unstable then "github:wawwior/stylix" else "github:danth/stylix/release-24.11";

      hyprland.url = if hyprland_pin then "github:hyprwm/Hyprland/v0.47.2" else "github:hyprwm/Hyprland";

      zen-browser = {
        url = "github:0xc000022070/zen-browser-flake";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };
    };
}
