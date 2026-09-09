{ config, ... }: {
  flake-bundles.bundles.hermes = {
    aspects = with config.flake.aspects; [
      (minecraft._.server {
        name = "cinnatastic";
        pack = {
          url = "https://raw.githubusercontent.com/wawwior/cinnatastic/main/pack.toml";
          hash = "sha256-86AwYiQUysdWErL4GPBFVLYvSr71Y4AhtSjfke8Vv/Y=";
        };
        loader = pkgs: pkgs.neoforgeServers.neoforge-1_21_1;
        properties = {
          server-port = 25565;
          spawn-protection = 0;
          motd = "cinnatastic! (hosted on NixOS :P)";
        };
      })
    ];
  };
}
