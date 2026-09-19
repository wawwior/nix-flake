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
    dendritic = {
      url = "github:wawwior/dendritic";
      inputs = lib.genAttrs [ "import-tree" "flake-parts" ] (input: {
        follows = input;
      });
    };
  };

  imports = [
    inputs.flake-file.flakeModules.default
    inputs.dendritic.flakeModule
  ];

  flake-file.outputs = "dendritic";

  systems = lib.systems.flakeExposed;

}
