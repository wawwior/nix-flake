{ pkgs, ... }:
{

  environment.systemPackages = [ pkgs.libsecret ];

  services.gnome.gnome-keyring = {
    enable = true;
  };

  programs.dconf.enable = true;

  programs.seahorse.enable = true;

  programs.ssh.askPassword = "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";

  security.pam.services.sddm.enableGnomeKeyring = true;

}
