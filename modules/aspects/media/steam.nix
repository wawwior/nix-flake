{
  flake.aspects.steam = {
    nixos = {
      programs = {
        steam.enable = true;
        gamemode.enable = true;
      };

      users.groups = {
        gamemode = { };
      };
    };
  };
}
