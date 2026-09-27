{ lib, ... }: {
  flake.aspects.xkb =
    layout:
    let
      layout' = builtins.head (lib.splitString "-" layout);
      variant = lib.removePrefix "${layout'}-" layout;
    in
    {
      nixos = {

        services.xserver = {
          xkb = {
            layout = layout';
            inherit variant;
          };
        };

        console.useXkbConfig = true;
      };
    };
}
