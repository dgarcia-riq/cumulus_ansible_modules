### TACACS Server Role

Configure TACACS Server

##### Example 

```python
tacacs:
  secret: tacacskey
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

