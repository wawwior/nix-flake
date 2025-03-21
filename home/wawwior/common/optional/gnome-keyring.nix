{ pkgs, ... }:
{
  home = {
    sessionVariables = {
      SSH_AUTH_SOCK = "\${XDG_RUNTIME_DIR}/keyring/ssh";
      SSH_ASKPASS = "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";
    };

    packages = [ pkgs.seahorse ];
  };

  systemd.user.services.gnome-keyring = {
    Unit = {
      Description = "GNOME Keyring";
      PartOf = [ "graphical-session-pre.target" ];
    };

    Service = {
      ExecStart = "/run/wrappers/bin/gnome-keyring-daemon --start --foreground";
      Restart = "on-abort";
    };

    Install = {
      WantedBy = [ "graphical-session-pre.target" ];
    };
  };
}
