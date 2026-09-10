{ config, lib, ... }: {
  flake.flakeBundleTransforms.autocompat = {
    transform =
      bundle@{
        aspects ? [ ],
        users ? { },
        ...
      }:
      bundle
      // (
        let
          pairs =
            names:
            lib.flatten (
              lib.crossLists
                (x: y: [
                  "${x}-${y}"
                  "${y}-${x}"
                ])
                [
                  names
                  names
                ]
            );

          additions =
            aspects:
            lib.pipe aspects [
              (map (aspect: aspect.name))
              pairs
              (map (name: config.flake.aspects.${name} or null))
              (builtins.filter (aspect: aspect != null))
            ];
        in
        {
          aspects = aspects ++ additions aspects;
          users = builtins.mapAttrs (
            _: user:
            user
            // (
              let
                aspects' = user.aspects or [ ];
              in
              {
                aspects = aspects' ++ additions (aspects ++ aspects');
              }
            )
          ) users;
        }
      );
  };
}
