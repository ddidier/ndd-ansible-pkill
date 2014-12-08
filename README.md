# Ansible PKill

Kill process by name.

## Requirements

None

## Role Variables

- pkill_name (required): the name of the process(es) to send the signal to (Extended Regular Expression).
- pkill_signal (defaults to SIGTERM): the signal to send.

## Dependencies

None

## Example Playbook

```yaml
- hosts: localhost
  sudo: true
  roles:
    - { role: pkill, pkill_name: 'apache', pkill_signal: 'SIGKILL' }
    - { role: pkill, pkill_name: 'nginx' }
```

## About

Copyright David DIDIER 2014

`ndd-ansible-pkill` is released under the terms of the LGPL License.
