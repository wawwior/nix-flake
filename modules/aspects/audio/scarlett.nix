{
  flake.aspects.scarlett = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.scarlett2 ];
    };
  };
}
