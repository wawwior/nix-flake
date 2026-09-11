{ config, ... }: {

  flake-bundles.bundles.hermes = {
    users = {
      root = {
        aspects = with config.flake.aspects; [
          # user aspects
          wheel
          keys
        ];
      };
    };
  };

}
