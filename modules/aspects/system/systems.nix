{
  flake.aspects = {
    x86_64-linux = {
      nixos = {
        nixpkgs.hostPlatform = "x86_64-linux";
      };
    };
    aarch64-linux = {
      nixos = {
        nixpkgs.hostPlatform = "aarch64-linux";
      };
    };
  };
}
