{
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
  };
}
