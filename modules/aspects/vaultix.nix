{ inputs, ... }: {

  flake-file.inputs = {
    nix-secrets.url = "git+file:/home/wawwior/projects/nix/secrets-flake?rev=98193909e888322e74f0739fc3dff94aca1e0b0d";
  };

  flake = {
    inherit (inputs.nix-secrets) vaultix;
  };

}
