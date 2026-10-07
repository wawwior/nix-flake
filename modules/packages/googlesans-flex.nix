{ lib, ... }: {
  perSystem = { pkgs, ... }: {
    packages.googlesans-flex = pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
      pname = "googlesans-flex";
      version = "4.007";

      src = pkgs.fetchFromGitHub {
        owner = "googlefonts";
        repo = "googlesans-flex";
        tag = "v${finalAttrs.version}";
        hash = "sha256-n3Ld16Qv9nN8tXl63FjXhNwb9aULQWEVkBgDDg057wg=";
      };

      nativeBuildInputs = [
        pkgs.fontc
      ];

      buildPhase = ''
        runHook preBuild

        mkdir -p fonts/variable
        fontc sources/GoogleSansFlex.glyphspackage --flatten-components --decompose-transformed-components --output-file "fonts/variable/GoogleSansFlex[opsz,slnt,wdth,wght].ttf"

        runHook postBuild
      '';

      installPhase = ''
        runHook preInstall

        mkdir -p $out/share/fonts/googlesans-flex
        cp fonts/variable/* $out/share/fonts/googlesans-flex          

        runHook postInstall
      '';

      meta = {
        description = "Google Sans Flex variable font";
        homepage = "https://github.com/googlefonts/googlesans-flex";
        license = lib.licenses.ofl;
        platforms = lib.platforms.all;
      };
    });
  };
}
