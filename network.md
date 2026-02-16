# Multi-Floor Building Network Topology
## Cisco Packet Tracer Implementation Guide

---

## Network Overview

This document outlines the network topology for a 3-floor building with distributed architecture. Each floor contains 4 wings with dedicated subnets, server rooms, and centralized management.

### Key Features
- 3 floors with inter-floor bridge connectivity
- Main routers on each floor connected via Ethernet
- 4 wings per floor with subnet segmentation
- Server room in one wing per floor
- Ground floor supervisor office connectivity
- Hierarchical network design

---

## Network Architecture Diagram

```
                    [INTERNET/WAN]
                          |
                    [Core Router]
                          |
        +-----------------+-----------------+
        |                 |                 |
   [Floor 3 BR]      [Floor 2 BR]      [Floor 1 BR]
   Bridge            Bridge            Bridge
        |                 |                 |
   [Floor 3 MR]      [Floor 2 MR]      [Floor 1 MR]
   Main Router       Main Router       Main Router
        |                 |                 |
   +----+----+       +----+----+       +----+----+
   |    |    |       |    |    |       |    |    |
  W1   W2  W3       W1   W2  W3       W1   W2  W3
  [S]       W4      [S]       W4      [S]       W4
                                               |
                                         [Supervisor]
                                         [Ground Office]

Legend:
BR = Bridge
MR = Main Router
W1-W4 = Wings (Network Segments)
[S] = Server Room
```

---

## IP Addressing Scheme

### Network Summary
- **Network Class**: Class B Private (172.16.0.0/12)
- **Base Network**: 172.16.0.0/16
- **Subnet Mask**: /24 for each wing (255.255.255.0)

### Floor 3 - IP Allocation

| Location | Network Address | Subnet Mask | IP Range | Default Gateway | VLAN |
|----------|----------------|-------------|-----------|-----------------|------|
| **Floor 3 Bridge** | 172.16.30.0/30 | 255.255.255.252 | 172.16.30.1-2 | - | - |
| **Floor 3 Main Router** | 172.16.31.0/24 | 255.255.255.0 | 172.16.31.1-254 | 172.16.31.1 | 31 |
| Wing 1 (Server Room) | 172.16.32.0/24 | 255.255.255.0 | 172.16.32.1-254 | 172.16.32.1 | 32 |
| Wing 2 | 172.16.33.0/24 | 255.255.255.0 | 172.16.33.1-254 | 172.16.33.1 | 33 |
| Wing 3 | 172.16.34.0/24 | 255.255.255.0 | 172.16.34.1-254 | 172.16.34.1 | 34 |
| Wing 4 | 172.16.35.0/24 | 255.255.255.0 | 172.16.35.1-254 | 172.16.35.1 | 35 |

### Floor 2 - IP Allocation

| Location | Network Address | Subnet Mask | IP Range | Default Gateway | VLAN |
|----------|----------------|-------------|-----------|-----------------|------|
| **Floor 2 Bridge** | 172.16.20.0/30 | 255.255.255.252 | 172.16.20.1-2 | - | - |
| **Floor 2 Main Router** | 172.16.21.0/24 | 255.255.255.0 | 172.16.21.1-254 | 172.16.21.1 | 21 |
| Wing 1 (Server Room) | 172.16.22.0/24 | 255.255.255.0 | 172.16.22.1-254 | 172.16.22.1 | 22 |
| Wing 2 | 172.16.23.0/24 | 255.255.255.0 | 172.16.23.1-254 | 172.16.23.1 | 23 |
| Wing 3 | 172.16.24.0/24 | 255.255.255.0 | 172.16.24.1-254 | 172.16.24.1 | 24 |
| Wing 4 | 172.16.25.0/24 | 255.255.255.0 | 172.16.25.1-254 | 172.16.25.1 | 25 |

### Floor 1 (Ground Floor) - IP Allocation

| Location | Network Address | Subnet Mask | IP Range | Default Gateway | VLAN |
|----------|----------------|-------------|-----------|-----------------|------|
| **Floor 1 Bridge** | 172.16.10.0/30 | 255.255.255.252 | 172.16.10.1-2 | - | - |
| **Floor 1 Main Router** | 172.16.11.0/24 | 255.255.255.0 | 172.16.11.1-254 | 172.16.11.1 | 11 |
| Wing 1 (Server Room) | 172.16.12.0/24 | 255.255.255.0 | 172.16.12.1-254 | 172.16.12.1 | 12 |
| Wing 2 | 172.16.13.0/24 | 255.255.255.0 | 172.16.13.1-254 | 172.16.13.1 | 13 |
| Wing 3 | 172.16.14.0/24 | 255.255.255.0 | 172.16.14.1-254 | 172.16.14.1 | 14 |
| Wing 4 (Supervisor Office) | 172.16.15.0/24 | 255.255.255.0 | 172.16.15.1-254 | 172.16.15.1 | 15 |

### Core Network

| Location | Network Address | Subnet Mask | IP Range |
|----------|----------------|-------------|-----------|
| Core Router Interconnect | 172.16.0.0/28 | 255.255.255.240 | 172.16.0.1-14 |
| DMZ (External Services) | 172.16.100.0/24 | 255.255.255.0 | 172.16.100.1-254 |

---

## Device Configuration

### Core Router Configuration

**Device**: Cisco Router (e.g., 2911 or 4331)

**Interfaces**:
```
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
```

**Routing Configuration**:
```
ip route 172.16.30.0 255.255.252.0 172.16.0.5
ip route 172.16.20.0 255.255.252.0 172.16.0.6
ip route 172.16.10.0 255.255.252.0 172.16.0.7
```

---

### Floor 3 Configuration

#### Bridge Device (BRG-F3)
**Device**: Cisco Switch (Layer 2/3) - e.g., 3650 or Bridge module

**Purpose**: Connects Floor 3 Main Router to Core Router

**Configuration**:
```
interface GigabitEthernet0/1
 description Uplink to Core Router
 ip address 172.16.30.2 255.255.255.252
 no shutdown

interface GigabitEthernet0/2
 description Downlink to Floor 3 Main Router
 ip address 172.16.30.1 255.255.255.252
 no shutdown
```

#### Floor 3 Main Router (MR-F3)
**Device**: Cisco Router 2911

**Configuration**:
```
interface GigabitEthernet0/0
 description Uplink to Floor 3 Bridge
 ip address 172.16.31.1 255.255.255.0
 no shutdown

interface GigabitEthernet0/1
 description Trunk to Floor 3 Switch
 no ip address
 no shutdown

interface GigabitEthernet0/1.32
 encapsulation dot1Q 32
 ip address 172.16.32.1 255.255.255.0

interface GigabitEthernet0/1.33
 encapsulation dot1Q 33
 ip address 172.16.33.1 255.255.255.0

interface GigabitEthernet0/1.34
 encapsulation dot1Q 34
 ip address 172.16.34.1 255.255.255.0

interface GigabitEthernet0/1.35
 encapsulation dot1Q 35
 ip address 172.16.35.1 255.255.255.0
```

#### Floor 3 Distribution Switch (SW-F3)
**Device**: Cisco Catalyst 2960 or 3560

**VLAN Configuration**:
```
vlan 32
 name F3-Wing1-ServerRoom
vlan 33
 name F3-Wing2
vlan 34
 name F3-Wing3
vlan 35
 name F3-Wing4

interface range FastEthernet0/1-6
 switchport mode access
 switchport access vlan 32
 spanning-tree portfast

interface range FastEthernet0/7-12
 switchport mode access
 switchport access vlan 33
 spanning-tree portfast

interface range FastEthernet0/13-18
 switchport mode access
 switchport access vlan 34
 spanning-tree portfast

interface range FastEthernet0/19-24
 switchport mode access
 switchport access vlan 35
 spanning-tree portfast

interface GigabitEthernet0/1
 description Trunk to Main Router
 switchport mode trunk
 switchport trunk allowed vlan 32,33,34,35
```

---

### Floor 2 Configuration

#### Bridge Device (BRG-F2)
**Device**: Cisco Switch (Layer 2/3)

**Configuration**:
```
interface GigabitEthernet0/1
 description Uplink to Core Router
 ip address 172.16.20.2 255.255.255.252
 no shutdown

interface GigabitEthernet0/2
 description Downlink to Floor 2 Main Router
 ip address 172.16.20.1 255.255.255.252
 no shutdown
```

#### Floor 2 Main Router (MR-F2)
**Device**: Cisco Router 2911

**Configuration**:
```
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
```

#### Floor 2 Distribution Switch (SW-F2)
**Device**: Cisco Catalyst 2960 or 3560

**VLAN Configuration**:
```
vlan 22
 name F2-Wing1-ServerRoom
vlan 23
 name F2-Wing2
vlan 24
 name F2-Wing3
vlan 25
 name F2-Wing4

interface range FastEthernet0/1-6
 switchport mode access
 switchport access vlan 22
 spanning-tree portfast

interface range FastEthernet0/7-12
 switchport mode access
 switchport access vlan 23
 spanning-tree portfast

interface range FastEthernet0/13-18
 switchport mode access
 switchport access vlan 24
 spanning-tree portfast

interface range FastEthernet0/19-24
 switchport mode access
 switchport access vlan 25
 spanning-tree portfast

interface GigabitEthernet0/1
 description Trunk to Main Router
 switchport mode trunk
 switchport trunk allowed vlan 22,23,24,25
```

---

### Floor 1 (Ground Floor) Configuration

#### Bridge Device (BRG-F1)
**Device**: Cisco Switch (Layer 2/3)

**Configuration**:
```
interface GigabitEthernet0/1
 description Uplink to Core Router
 ip address 172.16.10.2 255.255.255.252
 no shutdown

interface GigabitEthernet0/2
 description Downlink to Floor 1 Main Router
 ip address 172.16.10.1 255.255.255.252
 no shutdown
```

#### Floor 1 Main Router (MR-F1)
**Device**: Cisco Router 2911

**Configuration**:
```
interface GigabitEthernet0/0
 description Uplink to Floor 1 Bridge
 ip address 172.16.11.1 255.255.255.0
 no shutdown

interface GigabitEthernet0/1
 description Trunk to Floor 1 Switch
 no ip address
 no shutdown

interface GigabitEthernet0/1.12
 encapsulation dot1Q 12
 ip address 172.16.12.1 255.255.255.0

interface GigabitEthernet0/1.13
 encapsulation dot1Q 13
 ip address 172.16.13.1 255.255.255.0

interface GigabitEthernet0/1.14
 encapsulation dot1Q 14
 ip address 172.16.14.1 255.255.255.0

interface GigabitEthernet0/1.15
 encapsulation dot1Q 15
 ip address 172.16.15.1 255.255.255.0
 description Supervisor Office Network
```

#### Floor 1 Distribution Switch (SW-F1)
**Device**: Cisco Catalyst 2960 or 3560

**VLAN Configuration**:
```
vlan 12
 name F1-Wing1-ServerRoom
vlan 13
 name F1-Wing2
vlan 14
 name F1-Wing3
vlan 15
 name F1-Wing4-SupervisorOffice

interface range FastEthernet0/1-6
 switchport mode access
 switchport access vlan 12
 spanning-tree portfast

interface range FastEthernet0/7-12
 switchport mode access
 switchport access vlan 13
 spanning-tree portfast

interface range FastEthernet0/13-18
 switchport mode access
 switchport access vlan 14
 spanning-tree portfast

interface range FastEthernet0/19-24
 switchport mode access
 switchport access vlan 15
 spanning-tree portfast
 description Supervisor Office Ports

interface GigabitEthernet0/1
 description Trunk to Main Router
 switchport mode trunk
 switchport trunk allowed vlan 12,13,14,15
```

---

## Server Room Configuration

### Server Room Specifications (Each Floor)

**Location**: Wing 1 on each floor

**Devices**:
- File Server
- DHCP Server
- DNS Server
- Application Server
- Backup Server

#### Floor 3 Server Room (172.16.32.0/24)

| Device | IP Address | Subnet Mask | Default Gateway |
|--------|-----------|-------------|-----------------|
| File Server | 172.16.32.10 | 255.255.255.0 | 172.16.32.1 |
| DHCP Server | 172.16.32.11 | 255.255.255.0 | 172.16.32.1 |
| DNS Server | 172.16.32.12 | 255.255.255.0 | 172.16.32.1 |
| Application Server | 172.16.32.13 | 255.255.255.0 | 172.16.32.1 |
| Backup Server | 172.16.32.14 | 255.255.255.0 | 172.16.32.1 |
| Server Switch | 172.16.32.2 | 255.255.255.0 | 172.16.32.1 |

#### Floor 2 Server Room (172.16.22.0/24)

| Device | IP Address | Subnet Mask | Default Gateway |
|--------|-----------|-------------|-----------------|
| File Server | 172.16.22.10 | 255.255.255.0 | 172.16.22.1 |
| DHCP Server | 172.16.22.11 | 255.255.255.0 | 172.16.22.1 |
| DNS Server | 172.16.22.12 | 255.255.255.0 | 172.16.22.1 |
| Application Server | 172.16.22.13 | 255.255.255.0 | 172.16.22.1 |
| Backup Server | 172.16.22.14 | 255.255.255.0 | 172.16.22.1 |
| Server Switch | 172.16.22.2 | 255.255.255.0 | 172.16.22.1 |

#### Floor 1 Server Room (172.16.12.0/24)

| Device | IP Address | Subnet Mask | Default Gateway |
|--------|-----------|-------------|-----------------|
| File Server | 172.16.12.10 | 255.255.255.0 | 172.16.12.1 |
| DHCP Server | 172.16.12.11 | 255.255.255.0 | 172.16.12.1 |
| DNS Server | 172.16.12.12 | 255.255.255.0 | 172.16.12.1 |
| Application Server | 172.16.12.13 | 255.255.255.0 | 172.16.12.1 |
| Backup Server | 172.16.12.14 | 255.255.255.0 | 172.16.12.1 |
| Server Switch | 172.16.12.2 | 255.255.255.0 | 172.16.12.1 |

**Connection**: Each server room connects to Supervisor Office via routing through Floor 1 Main Router

---

## Supervisor Office Configuration

**Location**: Ground Floor (Floor 1), Wing 4
**Network**: 172.16.15.0/24

### Devices

| Device | IP Address | Subnet Mask | Default Gateway | Description |
|--------|-----------|-------------|-----------------|-------------|
| Supervisor PC 1 | 172.16.15.10 | 255.255.255.0 | 172.16.15.1 | Main workstation |
| Supervisor PC 2 | 172.16.15.11 | 255.255.255.0 | 172.16.15.1 | Backup workstation |
| Network Printer | 172.16.15.20 | 255.255.255.0 | 172.16.15.1 | Office printer |
| IP Phone | 172.16.15.30 | 255.255.255.0 | 172.16.15.1 | VoIP phone |
| Wireless AP | 172.16.15.40 | 255.255.255.0 | 172.16.15.1 | WiFi access |

### Access Control

The supervisor office has privileged access to all server rooms via ACLs:

```
ip access-list extended SUPERVISOR-ACCESS
 permit ip 172.16.15.0 0.0.0.255 172.16.12.0 0.0.0.255
 permit ip 172.16.15.0 0.0.0.255 172.16.22.0 0.0.0.255
 permit ip 172.16.15.0 0.0.0.255 172.16.32.0 0.0.0.255
 permit ip 172.16.15.0 0.0.0.255 any
 deny ip any any log
```

---

## DHCP Configuration

### DHCP Pools (Configure on each floor's server)

#### Floor 3 DHCP Configuration
```
ip dhcp excluded-address 172.16.32.1 172.16.32.20
ip dhcp excluded-address 172.16.33.1 172.16.33.10
ip dhcp excluded-address 172.16.34.1 172.16.34.10
ip dhcp excluded-address 172.16.35.1 172.16.35.10

ip dhcp pool FLOOR3-WING1
 network 172.16.32.0 255.255.255.0
 default-router 172.16.32.1
 dns-server 172.16.32.12
 domain-name f3wing1.local

ip dhcp pool FLOOR3-WING2
 network 172.16.33.0 255.255.255.0
 default-router 172.16.33.1
 dns-server 172.16.32.12
 domain-name f3wing2.local

ip dhcp pool FLOOR3-WING3
 network 172.16.34.0 255.255.255.0
 default-router 172.16.34.1
 dns-server 172.16.32.12
 domain-name f3wing3.local

ip dhcp pool FLOOR3-WING4
 network 172.16.35.0 255.255.255.0
 default-router 172.16.35.1
 dns-server 172.16.32.12
 domain-name f3wing4.local
```

#### Floor 2 DHCP Configuration
```
ip dhcp excluded-address 172.16.22.1 172.16.22.20
ip dhcp excluded-address 172.16.23.1 172.16.23.10
ip dhcp excluded-address 172.16.24.1 172.16.24.10
ip dhcp excluded-address 172.16.25.1 172.16.25.10

ip dhcp pool FLOOR2-WING1
 network 172.16.22.0 255.255.255.0
 default-router 172.16.22.1
 dns-server 172.16.22.12
 domain-name f2wing1.local

ip dhcp pool FLOOR2-WING2
 network 172.16.23.0 255.255.255.0
 default-router 172.16.23.1
 dns-server 172.16.22.12
 domain-name f2wing2.local

ip dhcp pool FLOOR2-WING3
 network 172.16.24.0 255.255.255.0
 default-router 172.16.24.1
 dns-server 172.16.22.12
 domain-name f2wing3.local

ip dhcp pool FLOOR2-WING4
 network 172.16.25.0 255.255.255.0
 default-router 172.16.25.1
 dns-server 172.16.22.12
 domain-name f2wing4.local
```

#### Floor 1 DHCP Configuration
```
ip dhcp excluded-address 172.16.12.1 172.16.12.20
ip dhcp excluded-address 172.16.13.1 172.16.13.10
ip dhcp excluded-address 172.16.14.1 172.16.14.10
ip dhcp excluded-address 172.16.15.1 172.16.15.50

ip dhcp pool FLOOR1-WING1
 network 172.16.12.0 255.255.255.0
 default-router 172.16.12.1
 dns-server 172.16.12.12
 domain-name f1wing1.local

ip dhcp pool FLOOR1-WING2
 network 172.16.13.0 255.255.255.0
 default-router 172.16.13.1
 dns-server 172.16.12.12
 domain-name f1wing2.local

ip dhcp pool FLOOR1-WING3
 network 172.16.14.0 255.255.255.0
 default-router 172.16.14.1
 dns-server 172.16.12.12
 domain-name f1wing3.local

ip dhcp pool FLOOR1-WING4-SUPERVISOR
 network 172.16.15.0 255.255.255.0
 default-router 172.16.15.1
 dns-server 172.16.12.12
 domain-name supervisor.local
```

---

## Security Configuration

### Access Control Lists (ACLs)

#### Inter-VLAN Security
```
! Restrict access between regular wings
ip access-list extended INTER-VLAN-SECURITY
 permit ip 172.16.32.0 0.0.0.255 172.16.12.0 0.0.0.255
 permit ip 172.16.22.0 0.0.0.255 172.16.12.0 0.0.0.255
 permit ip 172.16.12.0 0.0.0.255 any
 permit ip 172.16.15.0 0.0.0.255 any
 deny ip any 172.16.12.0 0.0.0.255 log
 deny ip any 172.16.22.0 0.0.0.255 log
 deny ip any 172.16.32.0 0.0.0.255 log
 permit ip any any
```

#### Server Room Protection
```
ip access-list extended SERVER-ROOM-PROTECT
 permit tcp any host 172.16.32.10 eq 445
 permit tcp any host 172.16.32.10 eq 139
 permit udp any host 172.16.32.11 eq 67
 permit udp any host 172.16.32.12 eq 53
 permit tcp 172.16.15.0 0.0.0.255 172.16.32.0 0.0.0.255
 deny ip any 172.16.32.0 0.0.0.255 log
```

### Port Security
```
! Apply to all access ports
interface range FastEthernet0/1-24
 switchport port-security
 switchport port-security maximum 2
 switchport port-security violation restrict
 switchport port-security mac-address sticky
```

---

## Routing Configuration

### Static Routes (if not using dynamic routing)

#### Core Router
```
ip route 172.16.30.0 255.255.252.0 172.16.0.5
ip route 172.16.20.0 255.255.252.0 172.16.0.6
ip route 172.16.10.0 255.255.252.0 172.16.0.7
ip route 0.0.0.0 0.0.0.0 [ISP Gateway]
```

#### Floor Routers
```
! Default route pointing to core
ip route 0.0.0.0 0.0.0.0 [Bridge IP]
```

### Dynamic Routing (OSPF - Recommended)

#### Core Router
```
router ospf 1
 router-id 172.16.0.1
 network 172.16.0.0 0.0.0.15 area 0
 network 172.16.100.0 0.0.0.255 area 0
 passive-interface GigabitEthernet0/3
```

#### Floor 3 Configuration
```
router ospf 1
 router-id 172.16.31.1
 network 172.16.30.0 0.0.0.3 area 0
 network 172.16.31.0 0.0.0.255 area 3
 network 172.16.32.0 0.0.3.255 area 3
```

#### Floor 2 Configuration
```
router ospf 1
 router-id 172.16.21.1
 network 172.16.20.0 0.0.0.3 area 0
 network 172.16.21.0 0.0.0.255 area 2
 network 172.16.22.0 0.0.3.255 area 2
```

#### Floor 1 Configuration
```
router ospf 1
 router-id 172.16.11.1
 network 172.16.10.0 0.0.0.3 area 0
 network 172.16.11.0 0.0.0.255 area 1
 network 172.16.12.0 0.0.3.255 area 1
```

---

## Quality of Service (QoS)

### Traffic Classification
```
class-map match-any VOICE
 match ip dscp ef

class-map match-any VIDEO
 match ip dscp af41

class-map match-any CRITICAL-DATA
 match ip dscp af31

policy-map WAN-QOS
 class VOICE
  priority percent 30
 class VIDEO
  bandwidth percent 20
 class CRITICAL-DATA
  bandwidth percent 30
 class class-default
  fair-queue
```

---

## Redundancy and High Availability

### HSRP Configuration (if dual routers per floor)

```
interface GigabitEthernet0/1.32
 standby 32 ip 172.16.32.1
 standby 32 priority 110
 standby 32 preempt
```

### Spanning Tree Configuration
```
spanning-tree mode rapid-pvst
spanning-tree extend system-id
spanning-tree vlan 1-4094 priority 24576
```

---

## Monitoring and Management

### SNMP Configuration
```
snmp-server community public RO
snmp-server community private RW
snmp-server location "Building Main - Floor [X]"
snmp-server contact "Network Admin"
snmp-server enable traps
```

### Syslog Configuration
```
logging 172.16.12.15
logging trap informational
logging source-interface GigabitEthernet0/0
```

### NTP Configuration
```
ntp server 172.16.12.16
ntp update-calendar
```

---

## Testing and Verification Commands

### Connectivity Tests
```
! Test basic connectivity
ping 172.16.32.10
ping 172.16.22.10
ping 172.16.12.10

! Test inter-floor routing
traceroute 172.16.35.50
traceroute 172.16.15.10

! Verify routing
show ip route
show ip ospf neighbor

! Verify VLAN configuration
show vlan brief
show interfaces trunk

! Verify spanning tree
show spanning-tree

! Check ACLs
show access-lists
show ip access-lists

! DHCP verification
show ip dhcp binding
show ip dhcp pool
```

---

## Equipment List

### Required Devices for Cisco Packet Tracer

| Device Type | Model | Quantity | Purpose |
|-------------|-------|----------|---------|
| Core Router | Cisco 2911 or 4331 | 1 | Central routing |
| Floor Router | Cisco 2911 | 3 | Per-floor routing |
| Bridge Device | Cisco 3560 or equivalent | 3 | Inter-floor connectivity |
| Distribution Switch | Cisco 2960-24TT | 3 | Per-floor distribution |
| Access Switch | Cisco 2960-24TT | 12+ | Wing connectivity |
| Servers | Generic Server | 15 | Server rooms |
| PCs | Generic PC | 40+ | End users |
| Laptops | Generic Laptop | 10+ | Mobile users |
| Printers | Generic Printer | 3+ | Printing services |
| Wireless AP | Generic Access Point | 12+ | WiFi coverage |

---

## Implementation Steps

### Step 1: Physical Topology
1. Place core router at the top center
2. Add three bridge devices below core router
3. Add three floor main routers below bridges
4. Connect bridges to core router with straight-through cables
5. Connect floor routers to respective bridges

### Step 2: Distribution Layer
1. Add distribution switches for each floor
2. Connect switches to floor routers using trunk ports
3. Configure VLANs on each switch

### Step 3: Access Layer
1. Add access switches for each wing
2. Connect access switches to distribution switches
3. Assign ports to appropriate VLANs

### Step 4: Server Rooms
1. Place servers in Wing 1 of each floor
2. Configure static IPs for all servers
3. Enable required services (DHCP, DNS, File, etc.)

### Step 5: End Devices
1. Add PCs, laptops, printers to appropriate wings
2. Configure for DHCP or static IPs
3. Connect to access switches

### Step 6: Configuration
1. Configure all IP addresses according to the plan
2. Set up routing (static or OSPF)
3. Configure VLANs and trunk links
4. Apply security policies and ACLs
5. Configure DHCP pools
6. Enable services on servers

### Step 7: Testing
1. Test connectivity within each wing
2. Test inter-wing connectivity
3. Test inter-floor connectivity
4. Test server access from supervisor office
5. Verify routing tables
6. Test DHCP functionality

---

## Troubleshooting Guide

### Common Issues and Solutions

| Issue | Possible Cause | Solution |
|-------|----------------|----------|
| No connectivity between floors | Bridge misconfiguration | Verify bridge interfaces and routing |
| DHCP not working | Server not configured | Check DHCP pools and excluded addresses |
| VLAN isolation | Missing trunk configuration | Verify trunk ports and allowed VLANs |
| Slow performance | No QoS configured | Implement QoS policies |
| Cannot reach server room | ACL blocking traffic | Review and adjust ACLs |
| Routing loops | STP not configured | Enable Spanning Tree Protocol |

---

## Maintenance Schedule

### Daily Tasks
- Monitor network performance
- Check system logs
- Verify backup completion

### Weekly Tasks
- Review security logs
- Test backup restoration
- Update documentation

### Monthly Tasks
- Review ACLs and firewall rules
- Performance analysis
- Capacity planning review

### Quarterly Tasks
- Security audit
- Device firmware updates
- Disaster recovery testing

---

## Appendix

### Cable Types
- **Straight-through**: PC to Switch, Router to Switch
- **Crossover**: Switch to Switch, Router to Router
- **Console**: Configuration access

### Default Credentials
- **Username**: admin
- **Password**: cisco123
- **Enable Secret**: class123

### Port Assignments
- GigabitEthernet: Uplinks and trunk connections
- FastEthernet: Access layer connections
- Console: Management access

---

## Notes

1. All passwords should be encrypted using `service password-encryption`
2. Enable SSH for secure remote access: `ip ssh version 2`
3. Disable unused ports: `shutdown`
4. Regular backups: `copy running-config tftp`
5. Document all changes in a change log

---

**Document Version**: 1.0  
**Last Updated**: February 2026  
**Prepared For**: Cisco Packet Tracer Implementation  
**Network Administrator**: [Your Name]

---

## Support Contacts

- **Network Admin**: [Contact Info]
- **Floor 1 Support**: [Contact Info]
- **Floor 2 Support**: [Contact Info]
- **Floor 3 Support**: [Contact Info]
- **Emergency**: [24/7 Contact]

---

*End of Document*
