{ lib, ... }: {
  flake.aspects.run0 = {
    nixos = {
      security = {
        run0 = {
          enable = true;
          enableSudoAlias = true;
        };
        polkit.enable = true;
        sudo.enable = false;
        wrappers = {
          su.enable = lib.mkForce false;
          sudoedit.enable = lib.mkForce false;
          sg.enable = lib.mkForce false;
          fusermount.enable = lib.mkForce false;
          fusermount3.enable = lib.mkForce false;
          pkexec.setuid = lib.mkForce false;
          newgrp.setuid = lib.mkForce false;
          newgidmap.setuid = lib.mkForce false;
          newuidmap.setuid = lib.mkForce false;
        };
      };
    };
  };
}
