
### Interfaces Role

Template for `/etc/network/interfaces`

##### Example 

```python
vxlan_local_loopback_subnet: 10.10.10
vxlan_anycast_loopback_subnet: 10.0.1
mlag_sysmac_prefix: 44:38:39:BE:EF
interface_profiles:
  - name: leaf_spine
    extras:
      - "alias to spine"
svi_profiles:
  - name: leaf_vlan10a
    id: 10
    vrf: RED
    address:
      - "10.1.10.2/24"
    address_virtual:
      - "00:00:00:00:00:1a 10.1.10.1/24"
  - name: leaf_vlan10b
    id: 10
    vrf: RED
    address:
      - "10.1.10.3/24"
    address_virtual:
      - "00:00:00:00:00:1a 10.1.10.1/24"
  - name: leaf_vlan20a
    id: 20
    vrf: RED
    address:
      - "10.1.20.2/24"
    address_virtual:
      - "00:00:00:00:00:1b 10.1.20.1/24"
  - name: leaf_vlan20b
    id: 20
    vrf: RED
    address:
      - "10.1.20.3/24"
    address_virtual:
      - "00:00:00:00:00:1b 10.1.20.1/24"
  - name: leaf_vlan30a
    id: 30
    vrf: BLUE
    address:
      - "10.1.30.2/24"
    address_virtual:
      - "00:00:00:00:00:1c 10.1.30.1/24"
  - name: leaf_vlan30b
    id: 30
    vrf: BLUE
    address:
      - "10.1.30.3/24"
    address_virtual:
      - "00:00:00:00:00:1c 10.1.30.1/24"
  - name: vlan4001
    id: 4001
    vrf: RED
    hwaddress: "{{ mlag.sysmac }}"
  - name: vlan4002
    id: 4002
    vrf: BLUE
    hwaddress: "{{ mlag.sysmac }}"
mlag_bond_profiles:
  - name: mlagBondProfileA
    bridge_access: 10
    extras:
      - "bond-lacp-bypass-allow yes"
      - "mstpctl-bpduguard yes"
      - "mstpctl-portadminedge yes"
  - name: mlagBondProfileB
    bridge_access: 20
    extras:
      - "bond-lacp-bypass-allow yes"
      - "mstpctl-bpduguard yes"
      - "mstpctl-portadminedge yes"
  - name: mlagBondProfileC
    bridge_access: 30
    extras:
      - "bond-lacp-bypass-allow yes"
      - "mstpctl-bpduguard yes"
      - "mstpctl-portadminedge yes"
  - name: mlagBondProfileFW
    bridge_vids: [10, 20, 30]
    extras:
      - "bond-lacp-bypass-allow yes"
      - "mstpctl-bpduguard yes"
      - "mstpctl-portadminedge yes"
port_profiles:
  - name: orphan_access_vlan10
    vlan: 10
vni_profiles:
  - name: vni10
    vlan_id: 10
    vxlan_id: 10
    extras:
      - "mstpctl-portbpdufilter yes"
      - "mstpctl-bpduguard yes"
      - "bridge-learning off"
      - "bridge-arp-nd-suppress on"
  - name: vni20
    vlan_id: 20
    vxlan_id: 20
    extras:
      - "mstpctl-portbpdufilter yes"
      - "mstpctl-bpduguard yes"
      - "bridge-learning off"
      - "bridge-arp-nd-suppress on"
  - name: vni30
    vlan_id: 30
    vxlan_id: 30
    extras:
      - "mstpctl-portbpdufilter yes"
      - "mstpctl-bpduguard yes"
      - "bridge-learning off"
      - "bridge-arp-nd-suppress on"
  - name: vniRED
    vlan_id: 4001
    vxlan_id: 4001
    extras:
      - "mstpctl-portbpdufilter yes"
      - "mstpctl-bpduguard yes"
      - "bridge-learning off"
      - "bridge-arp-nd-suppress on"
  - name: vniBLUE
    vlan_id: 4002
    vxlan_id: 4002
    extras:
      - "mstpctl-portbpdufilter yes"
      - "mstpctl-bpduguard yes"
      - "bridge-learning off"
      - "bridge-arp-nd-suppress on"
vni:
  profiles:
    - vniRED
    - vniBLUE
vrf:
  - name: RED
    vxlan_id: 4001
  - name: BLUE
    vxlan_id: 4002
bridge:
  vids:
    - 4001
    - 4002
svi:
  profiles:
    - vlan4001
    - vlan4002
loopback:
  ips:
    - "{{vxlan_local_loopback_subnet}}.63/32"
  vxlan_local_tunnel_ip: "{{vxlan_local_loopback_subnet}}.63"
  clag_vxlan_anycast_ip: "{{vxlan_anycast_loopback_subnet}}.254"
mlag:
  sysmac: "{{mlag_sysmac_prefix}}:FF"
  priority: primary
  peerlinks: [ swp49, swp50 ]
  backup: "{{vxlan_local_loopback_subnet}}.64"
  bonds:
    - { profile: mlagBondProfileFW, name: bond3, ports: [swp3], id: 1 }
interfaces:
  - { name: swp51, profile: leaf_spine }
  - { name: swp52, profile: leaf_spine }
  - { name: swp53, profile: leaf_spine }
  - { name: swp54, profile: leaf_spine }

```
