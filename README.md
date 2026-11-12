# Lab Electronics – Ansible

Ansible playbooks to manage the Rocky Linux 9 machines of the electronics lab
(group `lab_electronics` in [inventory.ini](inventory.ini)).

## Setup

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

- Hosts are listed in [inventory.ini](inventory.ini) (default user: `tech`).
- Logs are written to `logs/ansible.log`; failed hosts are saved in `retry/`.

## Common options

| Option | Meaning |
|---|---|
| `-K` | ask for the sudo password |
| `-k` | ask for the SSH password |
| `--limit <host>` | run on one host only |
| `--check` | dry run, change nothing |
| `--diff` | show file differences |
| `-v` | verbose output |
| `--limit @retry/<playbook>.retry` | re-run only on the hosts that failed |

Tip: always try on one host with `--check` first, then run on the whole group.

## Playbooks

### `update.yml` – system update

Removes Wine (conflicts with Mesa), fixes the GitHub CLI repository and its GPG
key, updates all packages and reboots only if needed.

```bash
ansible-playbook update.yml -K -v --limit 10.196.30.91 --check   # dry run on one host
ansible-playbook update.yml -K -v                                # whole group
```

### `deploy_cadence.yml` / `deploy_xilinx.yml` – environment scripts

Copy [files/cadence.sh](files/cadence.sh) and [files/xilinx.sh](files/xilinx.sh)
to `/etc/profile.d/` on every host. The new file is syntax-checked
(`bash -n`) before install, and the old one is kept as a backup.
To change the setup, edit the file in `files/` and run the playbook.

```bash
ansible-playbook deploy_cadence.yml -K --check --diff --limit 10.196.30.91   # preview
ansible-playbook deploy_cadence.yml -K --diff                                # whole group
```

(Same commands for `deploy_xilinx.yml`.)

### `check_mounts.yml` – mount check

Runs as a normal user (no sudo) and checks that:

1. `/eda` is mounted
2. `/tools` is mounted
3. `/home_ateneo/<USER>` is mounted and readable

Prints an OK/FAIL summary and marks the host as failed if any test fails.

```bash
ansible-playbook check_mounts.yml -e ansible_user=<USER> -k -v --limit 10.196.30.91
ansible-playbook check_mounts.yml -e ansible_user=<USER> -k -v
```
