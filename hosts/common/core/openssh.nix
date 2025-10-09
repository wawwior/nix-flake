{ ... }:
{
  services.openssh = {
    enable = true;

    settings = {
      PasswordAuthentication = false;
    };

    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
}
