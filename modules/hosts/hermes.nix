{
  inputs,
  config,
  ...
}:
{

  flake-bundles.bundles.hermes = {
    target = inputs.flake-bundles.flakeBundleTargets.host;
    resolvers = with inputs.flake-bundles.flakeBundleResolvers; [
      nixos
      home
      user
    ];
    system = "x86_64-linux";
    aspects = with config.flake.aspects; [

      # parameterized aspects

      (core {
        name = "hermes";
        version = "26.11";
      })
      (disko {
        disks = [
          "/dev/vda"
        ];
        swap = "4G";
      })
      (facter ./hermes/facter.json)

      # trivial aspects

      helix
    ];
  };

}
