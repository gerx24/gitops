docker build -t dns-lab .

docker rm -f dns-lab

docker run -d \
  --name dns-lab \
  --cap-add=NET_ADMIN \
  --net dns-net \
  --ip 192.168.100.53 \
  -p 1053:1053/udp \
  -p 1053:1053/tcp \
  -v /Users/gerson/gitops/dns-server/dnsmasq.conf:/etc/dnsmasq.conf \
  dns-lab \
  dnsmasq -k --port=1053




docker network create \
  --subnet=192.168.100.0/24 \
  --gateway=192.168.100.1 \
  --driver=bridge \
  dns-net
