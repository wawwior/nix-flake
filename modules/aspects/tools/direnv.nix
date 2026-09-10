{
  flake.aspects.direnv = {
    home = {
      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
        config = {
          hide_env_diff = true;
        };
      };
    };
  };
}
