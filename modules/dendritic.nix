{
  inputs,
  lib,
  ...
}:
{

  flake-file.inputs = {
    import-tree.url = "github:vic/import-tree";
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-aspects.url = "github:vic/flake-aspects";
  };

  imports = [
    inputs.flake-file.flakeModules.default
    inputs.flake-aspects.flakeModule
  ];

  flake-file.outputs = "dendritic";

  systems = lib.systems.flakeExposed;

}
