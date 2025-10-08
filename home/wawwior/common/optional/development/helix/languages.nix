{ pkgs, config, ... }:
{
  programs.helix.languages = {
    language-server = {
      nixd = {
        command = "nixd";
        config.nixd = {
          nixpgs = {
            expr = "import <nixpkgs> { }";
          };
          options = {
            nixos = {
              expr = "(builtins.getFlake \"${config.home.homeDirectory}/.nixos\").nixosConfigurations.${config.homeSpec.hostName}.options";
            };
          };
        };
      };
      jdtls = {
        command = "jdtls";
        config.java = {
          symbols = {
            includeSourceMethodDeclarations = true;
          };
        };
      };
    };
    language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        language-servers = [ "nixd" ];
      }
      {
        name = "java";
        scope = "source.java";
        file-types = [ "java" ];
        roots = [
          "pom.xml"
          "build.gradle"
          ".git"
        ];
        language-servers = [ "jdtls" ];
      }
    ];
  };
}
