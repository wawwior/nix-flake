{
  flake.aspects.yazi = {
    home = {
      programs.yazi = {
        enable = true;
        shellWrapperName = "yz";
      };
    };
  };
}
