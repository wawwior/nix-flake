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
      tinymist = {
        command = "tinymist";
        config = {
          exportPdf = "onSave";
          outputPath = "$root/target/$dir/$name";
          preview.background = {
            enabled = true;
            args = [
              "--data-plane-host=127.0.0.1:0"
              "--invert-colors=never"
              "--open"
            ];
          };
        };
      };
    };
    language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
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
      {
        name = "typst";
        language-servers = [ "tinymist" ];
      }
    ];
  };
}
