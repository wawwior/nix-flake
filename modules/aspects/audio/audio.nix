{
  flake.aspects.audio = {
    nixos = { pkgs, ... }: {
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
      environment.systemPackages = with pkgs; [
        qpwgraph
      ];
    };
    home = {
      capabilities.commands = {
        raiseVolume = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+";
        lowerVolume = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
        mute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        micMute = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      };
    };
  };
}
