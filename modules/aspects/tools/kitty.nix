{ self, lib, ... }: {
  flake.aspects.kitty = {
    home =
      {
        capabilities ? { },
        ...
      }:
      {
        programs.kitty = {
          enable = true;
          keybindings = {
            # maybe? ergonomic enough?
            "ctrl+shift+space" = "new_os_window_with_cwd";
          };
        }
        // lib.optionalAttrs (capabilities.fonts.monospace or null != null) {
          font = {
            inherit (capabilities.fonts.monospace) package name;
          };
        };
      };
    compat.provides = [
      {
        target = self.aspects.capabilities;
        aspect = {
          home = {
            capabilities.commands.terminal = "kitty";
          };
        };
      }
      {
        target = self.aspects.matugen;
        aspect = {
          nixos = { pkgs, ... }: {
            programs.matugen.templates.kitty = {
              input_path = pkgs.fetchurl {
                url = "https://raw.githubusercontent.com/InioX/matugen-themes/e4a9dbbd820f9f1c55b88b21b59e520bf6a702ed/templates/kitty-colors.conf";
                sha256 = "1dqwhbx3cczp00946fliph0bln2d6bwvdngrpl6kkvvqn72y87vc";
              };
              output_path = "~/kitty.conf";
            };
          };
          home = { config, ... }: {
            programs.kitty.extraConfig = ''
              include ${config.programs.matugen.theme.files}/kitty.conf
            '';
          };
        };
      }
    ];
  };
}
