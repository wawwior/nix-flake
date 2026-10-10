{ self, lib, ... }: {
  flake.aspects.material-rice =
    {
      settings-home,
      source-color ? null,
      wallpaper ? null,
    }:
    {
      includes =
        (with self.aspects; [
          dms-shell
          plymouth-material
          (dms-greeter settings-home)
          (matugen { inherit source-color; })
          (fonts (
            { pkgs, ... }: rec {
              default = sans;
              sans = {
                package = self.packages.${pkgs.stdenv.hostPlatform.system}.googlesans-flex;
                name = "Google Sans Flex";
              };
              monospace = {
                package = pkgs.nerd-fonts.googlesanscode;
                name = "GoogleSansCode NFM";
              };
            }
          ))
        ])
        ++ lib.optionals (wallpaper != null) [
          (self.aspects.wallpaper wallpaper)
        ];
    };
}
