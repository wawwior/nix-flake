{ self, ... }: {

  flake.aspects.lazygit = {
    home = {
      programs.lazygit = {
        enable = true;
        settings = {
          git = {
            overrideGpg = true;
          };
        };
      };
    };
    compat.provides = [
      {
        target = self.aspects.zsh;
        aspect = {
          home = {
            programs.lazygit = {
              enableZshIntegration = true;
            };
          };
        };
      }
    ];
  };
}
