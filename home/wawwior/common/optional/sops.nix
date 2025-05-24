{
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
    };
  };
}
