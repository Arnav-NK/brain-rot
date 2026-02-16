# Magma Core Network Simulation

## Overview

This project demonstrates a simulated Magma Core network where a laptop node accesses the internet through Magma services. The setup models key Magma core components and validates end-to-end connectivity using a simulated wireless network.

The topology can be implemented in **Cisco Packet Tracer (CPT)**. If CPT limitations are encountered, **GNS3** is recommended as an alternative simulation environment.

---

## Network Topology

### Architecture Diagram

```
                    ┌─────────────────────┐
                    │   Internet Cloud    │
                    └──────────┬──────────┘
                               │
                    ┌──────────▼──────────┐
                    │       VM2           │
                    │  NMS + Orc8r        │
                    │  (Orchestrator)     │
                    └──────────┬──────────┘
                               │
                               │ Ethernet
                               │
                    ┌──────────▼──────────┐
                    │       VM1           │
                    │   AGW (Access       │
                    │    Gateway)         │
                    │   [NAT Enabled]     │
                    └──────────┬──────────┘
                               │
                               │ Wi-Fi
                          ~~~~│~~~~
                         /    │    \
                        /     │     \
                       /      │      \
                      /       │       \
                ┌────▼────────▼────────▼───┐
                │        VM3               │
                │       Laptop             │
                │   (End User Device)      │
                └──────────────────────────┘
```

### Traffic Flow

```
┌────────┐         ┌─────┐         ┌─────────┐         ┌──────────┐
│ Laptop │ ─WiFi──>│ AGW │ ─ETH───>│ Orc8r   │ ─────> │ Internet │
│  (VM3) │         │(VM1)│         │  (VM2)  │         │          │
└────────┘         └─────┘         └─────────┘         └──────────┘
    │                 │                  │
    └─── Request ────>│                  │
                      │─── Route ───────>│
                      │<── Response ─────│
    │<── Reply ───────│                  │
```

---

## Virtual Machines / Nodes

| Node | Component | Description |
|------|-----------|-------------|
| **VM1** | **AGW (Access Gateway)** | Acts as the access gateway for user traffic. Provides Wi-Fi connectivity and NAT routing |
| **VM2** | **NMS + Orc8r** | Hosts the Network Management System and Orchestrator. Manages the Magma Core network |
| **VM3** | **Laptop** | End-user device powered by Magma-provided internet. Connects via Wi-Fi |

---

## Objective

Create a network where:

-  The laptop receives internet access through Magma Core
-  Traffic flows: `Laptop → AGW → Orc8r/NMS`
-  End-to-end connectivity is verified

---

## Implementation Using Cisco Packet Tracer (CPT)

### Steps

#### 1. Create Devices

Add three nodes:
- **Router/Server** (VM1 – AGW)
- **Server** (VM2 – NMS + Orc8r)
- **Laptop** (VM3)

#### 2. Configure Network Interfaces

```
AGW (VM1)
├── Interface: GigabitEthernet0/0
│   └── IP: 192.168.1.1/24 (Connected to Orc8r)
└── Interface: Wireless0
    └── IP: 10.0.0.1/24 (Wi-Fi Network)

Orc8r (VM2)
└── Interface: GigabitEthernet0/0
    └── IP: 192.168.1.2/24 (Connected to AGW)

Laptop (VM3)
└── Wireless Adapter
    └── IP: 10.0.0.100/24 (DHCP or Static)
```

- Connect AGW and Orc8r using Ethernet links
- Enable routing between VM1 and VM2
- Assign static IP addresses

#### 3. Wi-Fi Configuration

- Enable wireless access on AGW
- Configure SSID (e.g., `MagmaCore-WiFi`)
- Set security (WPA2-PSK recommended)
- Connect the Laptop to this Wi-Fi network

#### 4. Internet Simulation

- Configure **NAT** on AGW
- Route laptop traffic through AGW to Orc8r
- Verify IP assignment via **DHCP** or static configuration

**Sample NAT Configuration:**
```
ip nat inside source list 1 interface GigabitEthernet0/0 overload
access-list 1 permit 10.0.0.0 0.0.0.255
```

#### 5. Verification

Test connectivity:

```bash
# From Laptop (VM3)
ping 10.0.0.1        # Ping AGW
ping 192.168.1.2     # Ping Orc8r (if routed)
traceroute 8.8.8.8   # Verify routing path
```

**Expected Results:**
-  Laptop → AGW: Success
-  Laptop → Orc8r: Success
-  Internet access simulation via routing

---

## Alternative: Using GNS3 (Recommended)

If CPT does not fully support Magma-like behavior, use **GNS3** to:

- Run actual **Linux VMs** or **Docker containers**
- Deploy Magma Core services more realistically
- Bridge the laptop node to Magma Core via NAT or cloud interface

### Advantages of GNS3

| Feature | Benefit |
|---------|---------|
| **Linux Support** | Run actual Magma services on Ubuntu/Debian VMs |
| **Docker Integration** | Deploy containerized Magma components |
| **Realistic Routing** | Support for complex NAT, tunneling, and routing protocols |
| **Cloud Integration** | Bridge to real internet or cloud services |
| **Flexibility** | Closer to real Magma Core deployment scenarios |

### GNS3 Setup Overview

```
┌─────────────────────────────────────────────┐
│           GNS3 Environment                  │
├─────────────────────────────────────────────┤
│                                             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │  Docker  │  │  Linux   │  │  Client  │   │
│  │   AGW    │──│  Orc8r   │──│  Laptop  │   │
│  │Container │  │    VM    │  │   VM     │   │
│  └──────────┘  └──────────┘  └──────────┘   │
│       │              │              │       │
│       └──────────────┴──────────────┘       │
│                    │                        │
│         ┌──────────▼──────────┐             │
│         │   NAT/Cloud Node    │             │
│         │  (Internet Bridge)  │             │
│         └─────────────────────┘             │
└─────────────────────────────────────────────┘
```

---

## Expected Outcome

- ✅ Laptop successfully connects to the Magma-provided Wi-Fi
- ✅ Traffic flows through: `AGW → Orc8r`
- ✅ Network topology functions as a basic Magma Core simulation
- ✅ End-to-end connectivity verified via ping and traceroute

---

## IP Addressing Scheme

```
Network Segment          | IP Range           | Purpose
-------------------------|--------------------|---------------------------
Orc8r ↔ AGW Link         | 192.168.1.0/24     | Backend management network
AGW ↔ Laptop (Wi-Fi)     | 10.0.0.0/24        | User access network
Internet Simulation      | NAT (Public IPs)   | Simulated external network
```

---

## Notes

⚠️ **Important Considerations:**

- This setup is intended for **educational and simulation purposes**
- It does **not** represent a production-grade Magma deployment
- **GNS3 is preferred** for advanced experimentation
- For production deployments, refer to the [official Magma documentation](https://docs.magmacore.org/)

---

## Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| Laptop cannot connect to Wi-Fi | Check SSID and security settings on AGW |
| No internet on laptop | Verify NAT configuration and routing tables |
| Cannot ping Orc8r from laptop | Check routing between 10.0.0.0/24 and 192.168.1.0/24 |
| CPT limitations | Switch to GNS3 for better compatibility |

---

## References

- [Magma Core Official Documentation](https://docs.magmacore.org/)
- [Cisco Packet Tracer Documentation](https://www.netacad.com/courses/packet-tracer)
- [GNS3 Documentation](https://docs.gns3.com/)

---

## License

This is for educational purpose only

---

## Contributing

Contributions and improvements are welcome! Please submit issues or pull requests to enhance this simulation guide.

---

**Version:** 1.0  
**Last Updated:** February 2026
