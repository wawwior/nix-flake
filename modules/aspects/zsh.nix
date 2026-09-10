{ lib, ... }: {
  flake.aspects.zsh = {
    home = { config, capabilities, ... }: {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases =
          let
            commands = capabilities.commands or { };
            alias =
              alias: cmd:
              lib.optionalAttrs (commands.${cmd} or null != null) {
                ${alias} = commands.${cmd};
              };
          in
          { }
          // builtins.foldl' (acc: set: acc // set) { } [
            (alias "fetch" "fetch")
          ];

        dotDir = "${config.xdg.configHome}/zsh";
      };
    };
  };
}
