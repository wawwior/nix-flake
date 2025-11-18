{ inputs, pkgs, ... }:
let

  bta = pkgs.vanillaServers.vanilla.overrideAttrs (oldAttrs: {
    src = pkgs.fetchurl {
      url = "https://github.com/Better-than-Adventure/bta-download-repo/releases/download/v7.3_03/bta.v7.3_03.server.jar";
      hash = "sha256-WnCYDiwFRT0ZDtu3DpLMkpjYtJc5zErNPcbu1QufxUE=";
    };
  });

  mkForgeServer =
    mcVersion: forgeVersion: outputHash:
    let
      version = "${mcVersion}-${forgeVersion}";
    in
    pkgs.stdenvNoCC.mkDerivation rec {
      pname = "minecraft-server";
      inherit version;
      meta.mainProgram = "server";

      dontUnpack = true;
      dontConfigure = true;

      forge =
        pkgs.runCommand "forge-${version}"
          {
            inherit version;
            nativeBuildInputs = with pkgs; [
              cacert
              curl
              jre_headless
            ];

            outputHashMode = "recursive";
            inherit outputHash;
          }
          # sh
          ''
            mkdir -p "$out"

            curl https://maven.minecraftforge.net/net/minecraftforge/forge/${version}/forge-${version}-installer.jar -o ./installer.jar
            java -jar ./installer.jar --installServer "$out"
          '';

      buildPhase =
        # sh
        ''
          mkdir -p "$out/bin"
                    
          cp "${forge}/libraries/net/minecraftforge/forge/${forge.version}/unix_args.txt" "$out/bin/unix_args.txt"
        '';

      installPhase =
        # sh
        ''
          cat <<\EOF >>$out/bin/server
          ${pkgs.jre_headless}/bin/java "$@" "@${builtins.placeholder "out"}/bin/unix_args.txt" nogui
          EOF

          chmod +x $out/bin/server
        '';

      fixupPhase =
        # sh
        ''
          substituteInPlace $out/bin/unix_args.txt \
            --replace-fail "libraries" "${forge}/libraries"
        '';
    };

in
{

  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];

  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers = {
      bta = {
        enable = false;
        package = bta;
        serverProperties = {
          server-port = 25565;
          motd = "NixOS Minecraft server!";
        };
      };
      corporate-hell =
        let
          modpack = pkgs.fetchPackwizModpack {
            pname = "corporate-hell-pack";
            version = "latest";
            url = "https://raw.githubusercontent.com/wawwior/corporate-hell/create-5/pack.toml";
            packHash = "sha256-4SzK9yKTvZs9Z9Q8QWyvw18pQX+rj2FTEWxhj6xRI9U=";
          };
          inherit (inputs.nix-minecraft.lib) collectFilesAt;
        in
        {
          enable = true;
          autoStart = false;
          package = mkForgeServer "1.20.1" "47.4.6" "sha256-tW4cI1Sry8G6V6k6jvXxzadyIGmf6ttga+K2Biq2Kgg=";
          serverProperties = {
            server-port = 25565;
            motd = "NixOS Minecraft server!";
          };
          symlinks = collectFilesAt modpack "mods";
          files = collectFilesAt modpack "config";
        };
    };
  };

}
