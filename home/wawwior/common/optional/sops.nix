{
  config,
  ...
}:
{
  sops = {
    secrets = {
      "auth/public" = {
        path = "/home/wawwior/.ssh/id_auth_ed25519_key.pub";
      };
      "auth/private" = {
        path = "/home/wawwior/.ssh/id_auth_ed25519_key";
      };
      "sign/public" = {
        path = "/home/wawwior/.ssh/id_sign_ed25519_key.pub";
      };
      "sign/private" = {
        path = "/home/wawwior/.ssh/id_sign_ed25519_key";
      };
      "spotify-client-id" = { };
    };
    templates = {
      "authorized_keys" = {
        content = ''
          ${config.sops.placeholder."auth/public"}
        '';
        # TODO: find a better way to do this.
        path = ".ssh/authorized_keys";
      };
    };
  };
}
