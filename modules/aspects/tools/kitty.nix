{
  self,
  inputs,
  lib,
  ...
}:
{
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
          nixos = {
            programs.matugen.templates.kitty = {
              input_path = "${inputs.matugen-themes}/templates/kitty-colors.conf";
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
