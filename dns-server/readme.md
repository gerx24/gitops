docker build -t dns-lab .

docker rm -f dns-lab

docker run -d \
  --name dns-lab \
  --cap-add=NET_ADMIN \
  --net dns-net \
  --ip 192.168.100.53 \
  -p 53:53/udp \
  -p 53:53/tcp \
  -v /Users/gerson/gitops/dns-server/dnsmasq.conf:/etc/dnsmasq.conf \
  dns-lab




docker network create \
  --subnet=192.168.100.0/24 \
  --gateway=192.168.100.1 \
  --driver=bridge \
  dns-net


gerson@core:/etc/coredns$ cat Corefile
.:53 {
    hosts {
        172.26.1.99 krakenmoto-fw01.lab
        192.168.2.1 mac.lab
        fallthrough
    }
    forward . 8.8.8.8 8.8.4.4
    log
    errors
}



sudo systemctl daemon-reload
sudo systemctl restart coredns
sudo systemctl status coredns

gerson@core:/etc/systemd/system$ cat coredns.service
[Unit]
Description=CoreDNS DNS server
After=network.target

[Service]
ExecStart=/usr/local/bin/coredns -conf /etc/coredns/Corefile
Restart=on-failure
User=root
Group=root
AmbientCapabilities=CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target