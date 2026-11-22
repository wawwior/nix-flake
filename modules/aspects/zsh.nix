{ self, ... }: {
  flake.aspects.zsh = {

    nixos = { pkgs, ... }: {
      users.defaultUserShell = pkgs.zsh;
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;

        promptInit = ''
          PROMPT=$'\n%B%(!.%F{red}.%F{green})[%n@%m:%~]%(!.#.$)%f%b '
        '';
      };
    };

    home = {
      programs.zsh.enable = true;
    };

    compat.provides = [
      {
        target = self.aspects.preservation;
        aspect = {
          nixos = {
            system.userActivationScripts.zshrc = "touch .zshrc";
          };
        };
      }
    ];
  };
}
