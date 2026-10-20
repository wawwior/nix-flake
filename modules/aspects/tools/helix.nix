{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.aspects = {

    helix = {
      home = {
        home.sessionVariables = {
          EDITOR = "hx";
          VISUAL = "hx";
        };
        programs.helix = {
          enable = true;
          defaultEditor = true;
          settings = {
            editor = {
              mouse = false;
              bufferline = "multiple";
              line-number = "relative";
              # TODO: capability
              clipboard-provider = "wayland";
              cursor-shape = {
                normal = "block";
                insert = "bar";
                select = "underline";
              };
              color-modes = true;
              end-of-line-diagnostics = "hint";
              inline-diagnostics = {
                cursor-line = "error";
              };
            };
            keys = {
              normal = {
                esc = [
                  "collapse_selection"
                  "keep_primary_selection"
                ];
              };
            };
          };
        };
      };

      compat.provides = [
        {
          target = self.aspects.lsp-nix;
          aspect = {
            home = { pkgs, ... }: {
              programs.helix.languages = {
                language = [
                  {
                    name = "nix";
                    auto-format = true;
                    formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
                    language-servers = [ "nixd" ];
                  }
                ];
                language-server = {
                  nixd = {
                    command = "${pkgs.nixd}/bin/nixd";
                    config.nixd = {
                      nixpgs = {
                        expr = "import <nixpkgs> { }";
                      };
                    };
                  };
                };
              };
            };
          };
        }
        {
          target = self.aspects.lsp-typst;
          aspect = {
            home = { pkgs, ... }: {
              programs.helix.languages = {
                language = [
                  {
                    name = "typst";
                    language-servers = [ "tinymist" ];
                  }
                ];
                language-server = {
                  tinymist = {
                    command = "${pkgs.tinymist}/bin/tinymist";
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
              };
            };
          };
        }
        {
          target = self.aspects.matugen;
          aspect = {
            nixos = { pkgs, ... }: {
              programs.matugen.templates = {
                helix = {
                  input_path = "${inputs.matugen-themes}/templates/helix.toml";
                  output_path = "~/helix.toml";
                };
                helix-colors = {
                  input_path = (pkgs.formats.toml { }).generate "helix-colors.toml" (
                    {
                      inherits = "matugen";
                    }
                    // lib.mapAttrs (_: color: "{{colors.${color}.default.hex}}") {
                      "keyword" = "primary";
                      "keyword.control" = "purple";
                      "string" = "green";
                      "constant.character.escape" = "cyan";
                      "constant.numeric" = "orange";
                      "constant.builtin" = "orange";
                      "function" = "blue";
                      "function.macro" = "purple";
                      "type" = "yellow";
                      "type.builtin" = "yellow";
                      "constructor" = "blue";
                      "variable.parameter" = "red";
                      "namespace" = "cyan";
                      "attribute" = "cyan";
                      "tag" = "red";
                      "operator" = "secondary";
                    }
                  );
                  output_path = "~/helix-colors.toml";
                };
              };
            };
            home = { config, ... }: {
              programs.helix = {
                settings.theme = "matugen-colors";
              };
              xdg.configFile = {
                "helix/themes/matugen.toml".source = "${config.programs.matugen.theme.files}/helix.toml";
                "helix/themes/matugen-colors.toml".source =
                  "${config.programs.matugen.theme.files}/helix-colors.toml";
              };
            };
          };
        }
      ];
    };
  };
}
