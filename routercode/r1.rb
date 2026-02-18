interface GigabitEthernet0/0
 description Link to Floor 3 Bridge
 ip address 172.16.0.2 255.255.255.240
 no shutdown

interface GigabitEthernet0/1
 description Link to Floor 2 Bridge
 ip address 172.16.0.3 255.255.255.240
 no shutdown

interface GigabitEthernet0/2
 description Link to Floor 1 Bridge
 ip address 172.16.0.4 255.255.255.240
 no shutdown

interface GigabitEthernet0/3
 description WAN Link
 ip address [ISP Provided]
 no shutdown
