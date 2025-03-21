{ pkgs, ... }:
{

  environment.systemPackages = [ pkgs.libsecret ];
  services.gnome.gnome-keyring = {
    enable = true;
  };
  services.dbus.packages = [ pkgs.seahorse ];

  security.pam.services.sddm.enableGnomeKeyring = true;

}
