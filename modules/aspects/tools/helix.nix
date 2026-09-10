{ config, ... }: {
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
    };

    helix-lsp-full.includes = with config.flake.aspects; [
      helix-lsp-nix
      helix-lsp-typst
    ];

    helix-lsp-nix = {
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

    helix-lsp-typst = {
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
  };
}
