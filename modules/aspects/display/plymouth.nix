{
  flake.aspects.plymouth = {
    nixos = { pkgs, ... }: {
      boot = {
        initrd.systemd.enable = true;
        plymouth = {
          enable = true;
        };
      };
      systemd.services.plymouth-quit.serviceConfig.ExecStart = [
        ""
        "${pkgs.plymouth}/bin/plymouth quit --retain-splash"
      ];
    };
  };
}
