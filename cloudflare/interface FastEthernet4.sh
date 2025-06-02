interface FastEthernet4
 no ip address
 no shutdown
!
interface FastEthernet4.20
 encapsulation dot1Q 20
 pppoe enable
 pppoe-client dial-pool-number 1
 no shutdown
!
interface Dialer1
 mtu 1492
 ip address negotiated
 encapsulation ppp
 dialer pool 1
 dialer-group 1
 ppp chap hostname xxxxxxxxx
 ppp chap password xxxxxxx
 ppp pap sent-username xxxxxxxxxxx password xxxxxxx
 ip nat outside
 no shutdown
!
interface Vlan1
 ip address 192.168.100.1 255.255.255.0
 ip nat inside
 no shutdown
!
interface range FastEthernet0 - 3
 switchport access vlan 1
 switchport mode access
!
access-list 1 permit 192.168.100.0 0.0.0.255
ip nat inside source list 1 interface Dialer1 overload
!
ip dhcp excluded-address 192.168.100.1 192.168.100.10
ip dhcp pool LAN
 network 192.168.100.0 255.255.255.0
 default-router 192.168.100.1
 dns-server 8.8.8.8
!
dialer-list 1 protocol ip permit
!
end
write memory
