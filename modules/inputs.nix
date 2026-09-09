{ inputs, ... }:
{
  imports = [
    inputs.flake-file.flakeModules.default
  ];

  flake-file.inputs = {
    import-tree.url = "github:vic/import-tree";
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  flake-file.outputs = "dendritic";
}
