{ pkgs, ... }:
{
  home.packages = [
    pkgs.seahorse
  ];

  home.sessionVariables.SSH_ASKPASS = "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";
  home.sessionVariables.SSH_AUTH_SOCK = "\${XDG_RUNTIME_DIR}/keyring/ssh";

  services.gnome-keyring.enable = true;

}
