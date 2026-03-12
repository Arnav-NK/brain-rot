interface GigabitEthernet0/0
 description Uplink to Floor 2 Bridge
 ip address 172.16.21.1 255.255.255.0
 no shutdown

interface GigabitEthernet0/1
 description Trunk to Floor 2 Switch
 no ip address
 no shutdown

interface GigabitEthernet0/1.22
 encapsulation dot1Q 22
 ip address 172.16.22.1 255.255.255.0

interface GigabitEthernet0/1.23
 encapsulation dot1Q 23
 ip address 172.16.23.1 255.255.255.0

interface GigabitEthernet0/1.24
 encapsulation dot1Q 24
 ip address 172.16.24.1 255.255.255.0

interface GigabitEthernet0/1.25
 encapsulation dot1Q 25
 ip address 172.16.25.1 255.255.255.0
