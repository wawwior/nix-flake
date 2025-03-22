{ pkgs, ... }:
{
  home = {
    sessionVariables = {
      SSH_AUTH_SOCK = "\${XDG_RUNTIME_DIR}/keyring/ssh";
      SSH_ASKPASS = "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";
    };

    packages = [
      pkgs.seahorse
    ];
  };

  services.gnome-keyring.enable = true;
}
