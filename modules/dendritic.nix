{
  inputs,
  ...
}:
{

  flake-file.inputs = {
    flake-aspects.url = "github:vic/flake-aspects";
    flake-bundles.url = "github:wawwior/flake-bundles";
  };

  imports = [
    inputs.flake-aspects.flakeModule
    inputs.flake-bundles.flakeModule
  ];

}
