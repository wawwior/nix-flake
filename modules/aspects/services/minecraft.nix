{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  flake-file.inputs = {
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixpkgs = {
    overlays = [ inputs.nix-minecraft.overlay ];
  };

  flake.aspects.minecraft = {
    provides = {
      server =
        {
          name,
          pack ? null,
          loader ? null,
          properties ? { },
          ...
        }:
        {
          nixos =
            let
              loader' = if loader != null then loader pkgs else pkgs.vanillaServers.vanilla;
              inherit (inputs.nix-minecraft.lib) collectFilesAt;
            in
            {
              imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];

              services.minecraft-servers = {
                enable = true;
                eula = true;
                openFirewall = true;
                servers.${name} = {
                  enable = true;
                  autoStart = true;
                  package = loader';
                  serverProperties = properties;
                }
                // (lib.mkIf (pack != null) (
                  let
                    pack' = pkgs.fetchPackwizModpack {
                      inherit (pack) url hash;
                      name = "${name}-pack";
                      version = "latest";
                    };
                  in
                  {
                    symlinks = collectFilesAt pack' "mods";
                    files = collectFilesAt pack' "config";
                  }
                ));

              };
            };
        };
    };
  };
}
