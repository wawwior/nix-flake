{ self, ... }: {
  flake.aspects.kitty = {
    home = {
      programs.kitty = {
        enable = true;
        keybindings = {
          # maybe? ergonomic enough?
          "ctrl+shift+space" = "new_os_window_with_cwd";
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
    ];
  };
}
