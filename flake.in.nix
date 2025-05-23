{
  description = "Nix Flake";

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let

      inherit (self) outputs;
      inherit (nixpkgs) lib;

      mkHost = host: {
        ${host} = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hosts/nixos/${host}
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

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs";

    nixpkgs-unstable.url = "github:nixos/nixpkgs";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    declarative-flatpak.url = "github:in-a-dil-emma/declarative-flatpak";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    stylix.url = "github:nix-community/stylix";

    hyprland.url = "github:hyprwm/Hyprland";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    musnix.url = "github:musnix/musnix";
  };
}
