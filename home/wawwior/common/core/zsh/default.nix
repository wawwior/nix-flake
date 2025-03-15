{ pkgs, hostSpec, ... }:
{

  imports = [
    ./fzf.nix
    ./zoxide.nix
    ./oh-my-posh.nix
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
    };

    shellAliases = {
      os = "${hostSpec.home}/.nixos/genflake; nh os";
      fetch = "hyfetch";
    };

    initExtra = ''
      # fixes EDITOR being set to nano no matter what
      # i dont know what causes this bug
      # it used to work before i updated my flake.lock (Mar. 11 2025)
      # so now here we are
      export EDITOR=hx
    '';

    plugins = [
      {
        name = "sudo";
        src = pkgs.fetchFromGitHub {
          "owner" = "zap-zsh";
          "repo" = "sudo";
          "rev" = "b3e86492d6d48c669902b9fb5699a75894cfcebc";
          "sha256" = "sha256-+yMZO4HRF+dS1xOP/19Fneto8JxdVj5GiX3sXOoRdlM=";
        };
      }
    ];
  };
}
