{
  flake.aspects.zsh = {

    nixos = { pkgs, ... }: {
      users.defaultUserShell = pkgs.zsh;

      system.userActivationScripts.zshrc = "touch .zshrc";

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
  };
}
