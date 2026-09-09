{ ... }: {
  flake.aspects.core = { ... }: {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        git
        vim
        ripgrep
      ];
    };
  };
}
