
### FRR Role

Templates for `/etc/frr/frr.conf` and `/etc/frr/daemons`

##### Example 

```python
bgp_asn_prefix: 651
vxlan_local_loopback_subnet: 10.10.10
vxlan_anycast_loopback_subnet: 10.0.1
vrf:
  - name: RED
    vxlan_id: 4001
  - name: BLUE
    vxlan_id: 4002
bgp:
  asn: "{{ bgp_asn_prefix }}32"
  router_id: "{{vxlan_local_loopback_subnet}}.63"
  peergroups:
    - { name: underlay, remote_as: external }
  neighbors:
    - { interface: peerlink.4094, unnumbered: yes, remote_as: internal }
    - { interface: swp51, unnumbered: yes, peergroup: underlay }
    - { interface: swp52, unnumbered: yes, peergroup: underlay }
    - { interface: swp53, unnumbered: yes, peergroup: underlay }
    - { interface: swp54, unnumbered: yes, peergroup: underlay }
  extras:
    - "bgp bestpath as-path multipath-relax"
  address_family:
    - name: ipv4_unicast
      redistribute:
        - { type: connected }
    - name: l2vpn_evpn
      neighbors:
        - { interface: underlay, activate: yes }
      advertise_all_vni: yes
  vrfs:
    - name: RED
      router_id: "{{vxlan_local_loopback_subnet}}.63"
      extras:
        - "bgp bestpath as-path multipath-relax"
      address_family:
        - name: ipv4_unicast
          redistribute:
            - { type: static }
        - name: l2vpn_evpn
          extras:
            - "advertise ipv4 unicast"
    - name: BLUE
      router_id: "{{vxlan_local_loopback_subnet}}.63"
      extras:
        - "bgp bestpath as-path multipath-relax"
      address_family:
        - name: ipv4_unicast
          redistribute:
            - { type: static }
        - name: l2vpn_evpn
          extras:
            - "advertise ipv4 unicast"

```
