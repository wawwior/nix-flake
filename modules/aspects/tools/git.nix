{
  flake.aspects.git =
    {
      user ? { },
      ...
    }:
    {
      home = {
        programs.git = {
          enable = true;
          lfs.enable = true;
          settings = {
            inherit user;

            init.defaultBranch = "main";
            push.autoSetupRemote = true;
            pull.rebase = true;

            # TODO: signing
            gpg.format = "ssh";
          };

          signing.format = "openpgp";
        };
      };
    };
}
