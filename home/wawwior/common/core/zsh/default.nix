{
  pkgs,
  config,
  ...
}:
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

    dotDir = "${config.xdg.configHome}/zsh";

    shellAliases = {
      # TODO: change this to a root dir
      os = "${config.home.homeDirectory}/.nixos/genflake; nh os";
      fetch = "hyfetch";
      ssh = "kitten ssh";
    };

    plugins = [
      {
        name = "sudo";
        src = pkgs.fetchFromGitHub {
          owner = "zap-zsh";
          repo = "sudo";
          rev = "b3e86492d6d48c669902b9fb5699a75894cfcebc";
          sha256 = "sha256-+yMZO4HRF+dS1xOP/19Fneto8JxdVj5GiX3sXOoRdlM=";
        };
      }
      # {
      #   name = "zsh-helix-mode";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "Multirious";
      #     repo = "zsh-helix-mode";
      #     rev = "97bbe550dbbeba3c402b6b3cda0abddf6e12f73c";
      #     sha256 = "sha256-9AXeKtZw3iXxBO+jgYvFv/y7fZo+ebR5CfoZIemG47I=";
      #   };
      # }
    ];
  };
}
