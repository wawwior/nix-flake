{ ... }:
{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 2 --keep-since 3d --nogcroots";
    # TODO: fix
    flake = "/home/wawwior/.nixos";
  };
}
