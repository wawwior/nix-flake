{ config, ... }:
{
  programs.git = {

    enable = true;
    settings = {
      user = {
        name = "wawwior";
        email = "45405580+wawwior@users.noreply.github.com";
      };

      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;

      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "${config.home.homeDirectory}/.ssh/id_sign_ed25519_key.pub";
    };

  };
}
