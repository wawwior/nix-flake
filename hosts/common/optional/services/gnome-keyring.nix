{ pkgs, ... }:
{

  services.gnome.gnome-keyring = {
    enable = true;
  };

  programs = {
    dconf.enable = true;
  };

  services.dbus.packages = [ pkgs.seahorse ];

  security.pam.services.sddm.enableGnomeKeyring = true;

}
