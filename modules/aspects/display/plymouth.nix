{
  flake.aspects.plymouth = {
    nixos = { pkgs, ... }: {
      boot = {
        initrd = {
          systemd.enable = true;
          verbose = false;
        };
        plymouth = {
          enable = true;
        };
        consoleLogLevel = 0;
        kernelParams = [
          "systemd.show_status=false"
          "rd.systemd.show_status=false"
          "udev.log_level=3"
          "rd.udev.log_level=3"
          "vt.global_cursor_default=0"
        ];
      };
      systemd.services.plymouth-quit.serviceConfig.ExecStart = [
        ""
        "${pkgs.plymouth}/bin/plymouth quit --retain-splash"
      ];
    };
  };
}
