# NVIDIA Cumulus Linux Roles

[![Pipeline](https://gitlab.com/cumulus-consulting/goldenturtle/cumulus_evpn/badges/master/pipeline.svg)](https://gitlab.com/cumulus-consulting/goldenturtle/cumulus_evpn/pipelines)
[![License](https://img.shields.io/badge/License-Apache%202.0-83389B.svg)](https://opensource.org/licenses/Apache-2.0)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)
[![Slack Status](https://img.shields.io/badge/Slack-2800+-F1446F)](https://slack.cumulusnetworks.com)
[![Code of Conduct](https://img.shields.io/badge/Contributing-Code%20of%20Conduct-1EB5BD)](https://docs.cumulusnetworks.com/contributor-guide/#contributor-covenant-code-of-conduct)

<img src="https://www.ansible.com/hubfs/2016_Images/Assets/Ansible-Mark-Large-RGB-BlackOutline.png" height="150" title="Ansible" align="right" /> 
<img src="https://gitlab.com/cumulus-consulting/goldenturtle/cldemo2/-/raw/master/documentation/images/cumulus-logo.svg" height="150" title="Cumulus Networks" align="right" /> 

Modules to configure a Cumulus Linux Switch

- [NVIDIA Cumulus Linux Roles](#NVIDIA-cumulus-linux-roles)
  * [Roles](#roles)
    + [backup](automation/roles/backup/README.md)
    + [dns](automation/roles/dns/README.md)
    + [frr](automation/roles/frr/README.md)
    + [hostname](automation/roles/hostname/README.md)
    + [interfaces](automation/roles/interfaces/README.md)
    + [motd](automation/roles/motd/README.md)
    + [ntp](automation/roles/ntp/README.md)
    + [ptm](automation/roles/ptm/README.md)
    + [snmp](automation/roles/snmp/README.md)
    + [ssh](automation/roles/ssh/README.md)
    + [syslog](automation/roles/syslog/README.md)
    + [tacacs_client](automation/roles/tacacs_client/README.md)
    + [tacacs_server](automation/roles/tacacs_server/README.md)


## Variables

### backup
Backup config files to the [config dir](automation/config)
List of file locations to copy from switches

```python
backup.files:
  - "/etc/network/interfaces"
  - "/etc/frr/frr.conf"
```

### dns
Set resolve.conf using a template

```python
dns.domain: "cumulusnetworks.com"
```
```python
dns.search_domain:
  - cumulusnetworks.com
```
```python
dns.servers:
    ipv4:
      - "1.1.1.1"
      - "8.8.8.8"
    vrf: mgmt
```

### frr
Free Range Routing in /etc/frr/frr.conf and /etc/frr/daemons using idempotent templating

See: [frr documentation](automation/roles/frr/README.md)

### hostname
hostname using ansible hostname module

```python
hostname: leaf01
```

### interfaces
ifupdown2 in /etc/network/interfaces using idempotent templating

See: [interfaces documentation](automation/roles/interfaces/README.md)

### motd
Message of the Day in /etc/motd and /etc/issue.net

```python
motd: |
  Welcome to Cumulus Linux!
  MOTD Contents
```

### ntp
Network Time Protocol

```python
ntp.timezone: America/Los_Angeles
```
```python
ntp.server_ips:
    - 0.cumulusnetworks.pool.ntp.org
    - 1.cumulusnetworks.pool.ntp.org
    - 2.cumulusnetworks.pool.ntp.org
    - 3.cumulusnetworks.pool.ntp.org
```

### ptm
Prescriptive Topology Manager.

Place the topology.dot file in the ptm role. `roles/ptm/files/topology.dot`.

### snmp
SNMP

Add your variables for listening addresses under snmp.addresses as a list. Currently supports setting a read only community.
```python
snmp:
  addresses:
    - "{{ hostvars[inventory_hostname]['ansible_eth0']['ipv4']['address'] }}@mgmt"
    - "udp6:[::1]:161"
  rocommunity: public
```

### ssh
SSH quality of life settings. Currently sets a timeout and turns off useDNS sshd option.

### syslog
remote syslog servers using mgmt vrf.

Set the syslog.servers list variable. This is the syslog restination and only supports the mgmt vrf currently.
```python
syslog:
  servers:
    - 192.168.200.1
```

### tacacs_client
TACACS+ client and TACACS user log permissions

tacacs+ client 
```python
tacacs:
  vrf: mgmt
  secret: tacacskey
  server_ips:
    - 192.168.200.1
```

### tacacs_server
TACACS+ Server

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
