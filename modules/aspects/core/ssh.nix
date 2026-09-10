{
  flake.aspects.core = { ... }: {

    nixos = {
      services.openssh.enable = true;
    };

    home = { config, ... }: {
      services.ssh-agent.enable = true;
      programs.ssh = {
        enable = true;

        # TODO: wait for upstream to default this
        enableDefaultConfig = false;

        # TODO: identityFile

        settings = {
          "*" = {
            controlMaster = "auto";
            controlPath = "${config.home.homeDirectory}/.ssh/sockets/S.%r@%h:%p";
            controlPersist = "20m";
            addKeysToAgent = "yes";
          };
          "git" = {
            host = "github.com gitlab.* git.*";
            user = "git";
            forwardAgent = true;
            identitiesOnly = true;
          };
        };
      };
    };
  };
}
