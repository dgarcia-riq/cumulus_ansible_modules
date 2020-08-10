
### TACACS Client Role

Configure TACACS Client

##### Example 

```python
tacacs:
  vrf: mgmt
  secret: tacacskey
  server_ips:
    - 192.168.200.1
  users:
    - name: basicuser
      password: password
      group: basics
    - name: adminuser
      password: password
      group: admins
  groups:
    # admin group can do anything on network gear
    - name: admins
      priv_level: 15
    # basic group can run show commands and diagnostics but not change system configuration
    - name: basics
      priv_level: 1
```