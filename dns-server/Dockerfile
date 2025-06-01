FROM alpine:latest
RUN apk add --no-cache dnsmasq && mkdir -p /var/log && touch /var/log/dnsmasq.log
COPY dnsmasq.conf /etc/dnsmasq.conf
CMD ["dnsmasq", "-k"]
