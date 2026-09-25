{
  flake.aspects.kitty = {
    home = {
      capabilities.commands.terminal = "kitty";
      programs.kitty = {
        enable = true;
        keybindings = {
          # maybe? ergonomic enough?
          "ctrl+shift+space" = "new_os_window_with_cwd";
        };
      };
    };
  };
}
