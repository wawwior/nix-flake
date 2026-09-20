{ ... }: {
  flake.aspects.wg-tunnel =
    {
      ip,
      key,
      peer,
      mtu ? 1420,
      port ? 51820,
      wan ? "eth0",
    }:
    let
      peerPort = toString (peer.port or 51821);
    in
    {
      nixos = {
        boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

        networking = {
          wireguard.interfaces.wg-tunnel = {
            ips = [ (ip + "/24") ];
            listenPort = port;
            privateKeyFile = key;
            inherit mtu;
            peers = [
              {
                publicKey = peer.key;
                allowedIPs = [ (peer.ip + "/32") ];
              }
            ];
          };

          firewall = {
            allowedUDPPorts = [ port ];
            filterForward = true;
            extraForwardRules = ''
              iifname "${wan}" oifname "wg-tunnel" ip daddr ${peer.ip} udp dport ${peerPort} accept
            '';
          };

          nftables = {
            enable = true;
            tables.wg-relay = {
              family = "ip";
              content = ''
                chain prerouting {
                  type nat hook prerouting priority dstnat; policy accept;
                  iifname "${wan}" udp dport ${peerPort} dnat to ${peer.ip}:${peerPort}
                }

                chain postrouting {
                  type nat hook postrouting priority srcnat; policy accept;
                  oifname "wg-tunnel" ip daddr ${peer.ip} udp dport ${peerPort} masquerade
                }
              '';
            };
          };
        };
      };
    };
}
