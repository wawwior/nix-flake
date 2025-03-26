{ pkgs, ... }:
{

  home.sessionVariables.SSH_ASKPASS = "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";
  home.sessionVariables.SSH_AUTH_SOCK = "\${XDG_RUNTIME_DIR}/keyring/ssh";

  systemd.user.services.gnome-keyring = {
    Unit = {
      Description = "GNOME Keyring";
      PartOf = [ "graphical-session-pre.target" ];
    };
    Service = {
      ExecStart = "${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --start --components=ssh,secrets";
      Restart = "on-abort";
    };

    Install = {
      WantedBy = [ "graphical-session-pre.target" ];
    };
  };

}
