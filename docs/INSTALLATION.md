# Installation and node onboarding

## Panel host
1. Provision a fresh supported Ubuntu LTS VPS and a DNS hostname you control.
2. Keep any existing hosting panel on separate services/ports and separate infrastructure where possible.
3. Clone this repository, copy `.env.example` to `.env`, fill placeholders, and set permissions to `600`.
4. Run `sudo bash install.sh`. In this scaffold it only validates configuration and exits; it does not deploy services.
5. Implement the production installer only after application services, migrations, health checks and rollback are complete.

## Compute node
The `install-node.sh` script is deliberately a no-op placeholder. Do not run it expecting a working agent. Production node onboarding must:
- verify supported OS and hardware;
- install pinned, signed artifacts;
- enroll with a one-time token/certificate;
- establish authenticated outbound communication;
- apply firewall rules only after operator confirmation;
- provide rotation, revocation, uninstall and rollback.

## KVM prerequisites
KVM requires host CPU virtualization support and kernel modules; nested virtualization may be restricted by some VPS providers. Verify the provider permits virtualization before purchasing or assigning VPS workloads. Use dedicated compute nodes and keep libvirt control sockets private.
