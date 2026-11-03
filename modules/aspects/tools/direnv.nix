{ self, ... }: {
  flake.aspects.direnv = {
    home = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        config = {
          hide_env_diff = true;
        };
      };
    };

    compat.provides = [
      {
        target = self.aspects.zsh;
        aspect = {
          home = {
            programs.direnv = {
              enableZshIntegration = true;
            };
          };
        };
      }
    ];
  };
}
