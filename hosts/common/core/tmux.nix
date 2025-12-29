{ inputs, pkgs, ... }:
let
  minimal-tmux = inputs.minimal-tmux.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{

  programs.tmux = {
    enable = true;
    clock24 = true;
    shortcut = "space";
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    escapeTime = 0;
    reverseSplit = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      minimal-tmux
    ];

    extraConfig =
      #sh
      ''
        set -g default-terminal "xterm-kitty"
        bind v split-window -h
        bind s split-window -v

        # 1 based indexing
        set -g base-index 1
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on
      '';
  };

}
