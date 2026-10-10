{ self, ... }: {

  # see <editor>.nix for implementation
  flake.aspects = {

    lsp-nix = { };
    lsp-typst = { };

    lsp-full.includes = with self.aspects; [
      lsp-nix
      lsp-typst
    ];
  };
}
