{
  flake.aspects.systemd-hardened = {
    nixos = {
      systemd.coredump.enable = false;

      security.pam.loginLimits = [
        {
          domain = "*";
          type = "-";
          item = "core";
          value = "0";
        }
      ];
    };
  };
}
