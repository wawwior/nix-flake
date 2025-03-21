{
  lib,
  stdenv,
}:
let
  pname = "steamcontroller-udev-rules";
in
stdenv.mkDerivation {

  inherit pname;

  version = "1.0.0";

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./steamcontroller.rules
    ];
  };

  installPhase = ''
    mkdir $out
    cp -v ./steamcontroller.rules $out/70-steamcontroller.rules
  '';

}
