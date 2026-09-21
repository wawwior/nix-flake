{
  flake.aspects.immutable-users = {
    nixos = {
      users.mutableUsers = false;
    };
  };
}
