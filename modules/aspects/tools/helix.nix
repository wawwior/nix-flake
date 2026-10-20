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
                    let
                      colors = {
                        "attribute" = "orange";
                        "constant" = "orange";
                        "constant.character.escape" = "cyan";
                        "constant.numeric" = "orange";
                        "constant.builtin" = "orange";
                        "constructor" = "blue";
                        "function" = "blue";
                        "keyword" = "purple";
                        "keyword.control" = "purple";
                        "label" = "purple";
                        "namespace" = "purple";
                        "special" = "blue";
                        "string" = "green";
                        "tag" = "red";
                        "type" = "yellow";
                        "variable" = "red";
                        "variable.parameter" = "red";
                        "variable.other.member" = "blue";

                        "diff.delta" = "orange";
                        "diff.minus" = "red";
                        "diff.plus" = "green";

                        "error" = "red";
                        "warning" = "orange";
                        "info" = "blue";

                        "markup.bold" = "yellow";
                        "markup.heading.1" = "blue";
                        "markup.heading.2" = "red";
                        "markup.heading.3" = "orange";
                        "markup.heading.4" = "yellow";
                        "markup.heading.5" = "green";
                        "markup.heading.6" = "cyan";
                        "markup.italic" = "purple";
                        "markup.link.text" = "red";
                        "markup.link.url" = "orange";
                        "markup.list" = "red";
                        "markup.quote" = "cyan";
                        "markup.raw" = "green";

                        "ui.text.directory" = "blue";
                        "ui.virtual.jump-label" = "yellow";
                      };

                      modifiers = {
                        "markup.bold" = [ "bold" ];
                        "markup.heading.1" = [ "bold" ];
                        "markup.heading.2" = [ "bold" ];
                        "markup.heading.3" = [ "bold" ];
                        "markup.heading.4" = [ "bold" ];
                        "markup.heading.5" = [ "bold" ];
                        "markup.heading.6" = [ "bold" ];
                        "markup.italic" = [ "italic" ];
                        "markup.link.url" = [ "underlined" ];
                        "ui.virtual.jump-label" = [ "bold" ];
                      };

                    in
                    {
                      inherits = "matugen";
                    }
                    // lib.mapAttrs (
                      scope: color:
                      {
                        fg = "{{colors.${color}.default.hex}}";
                      }
                      // lib.optionalAttrs (modifiers ? ${scope}) { modifiers = modifiers.${scope}; }
                    ) colors
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
