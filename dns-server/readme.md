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
