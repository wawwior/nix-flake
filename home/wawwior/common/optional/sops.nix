{ ... }:
{
  sops = {
    secrets = {
      "auth" = {
        path = "/home/wawwior/.ssh/id_auth_ed25519_key";
      };
      "sign" = {
        path = "/home/wawwior/.ssh/id_sign_ed25519_key";
      };
      "spotify-client-id" = { };
    };
  };
}
