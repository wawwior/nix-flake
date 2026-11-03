{ self, ... }: {
  flake.aspects.nitch = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.nitch
      ];
    };
    compat.provides = [
      {
        target = self.aspects.zsh;
        aspect = {
          nixos = {
            programs.zsh.shellAliases = {
              fetch = "nitch";
            };
          };
        };
      }
    ];
  };
}
