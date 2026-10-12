# PiratesNodes

**Independent hosting control panel specification and implementation scaffold.**

PiratesNodes is planned as a standalone hosting platform for Minecraft game servers and KVM/libvirt virtual machines. It has its own frontend, API, database, node agent, branding and billing domain. It does **not** install, modify, migrate, or depend on Pterodactyl.

> **Status warning:** This repository package is a GitHub-ready specification/scaffold, not a complete production hosting panel. Core provisioning, billing, payment gateways, Discord integration, and the node agent are not implemented here. `install.sh` intentionally performs preflight checks and prints the next steps; it does not claim to deploy a working panel.

## Target deployment

- Target: fresh, supported Ubuntu LTS VPS (validate the exact release before deployment).
- Panel hostname: supplied by operator at deployment time; DNS must point to the panel VPS.
- Products: Minecraft hosting and KVM VPS hosting.
- VM backend: KVM + libvirt on dedicated compute nodes with hardware virtualization enabled.
- Isolation: containers for game servers; libvirt/KVM for VPS instances.
- Existing Pterodactyl: leave it untouched. Do not reuse its database, files, ports, Docker networks, or services.

## Repository status

See [`docs/FEATURE_STATUS.md`](docs/FEATURE_STATUS.md) for the authoritative implemented/partial/placeholder matrix. A folder, interface mockup, or API contract does not imply a working feature.

## Quick start

```bash
git clone https://github.com/YOUR-ORG/PiratesNodes.git
cd PiratesNodes
cp .env.example .env
chmod 600 .env
# Edit .env with real values. Never commit it.
sudo bash install.sh
```

The current installer is a **preflight-only scaffold**. It checks basic host requirements and configuration safety, then exits with an explicit notice that production deployment is not implemented. It will not install packages, change firewall rules, configure DNS/TLS, create VMs, or touch Pterodactyl.

## Suggested build sequence

1. Lock down architecture, threat model, and supported OS versions.
2. Implement API, database migrations, sessions, MFA, audit events, RBAC and tests.
3. Implement a signed, mutually authenticated node-agent protocol and idempotent job queue.
4. Implement Minecraft provisioning using isolated containers and strict resource/port quotas.
5. Implement KVM provisioning on separate compute nodes using libvirt; do not expose libvirt to the public network.
6. Implement plans, invoices, entitlements, payment-provider webhooks and reconciliation.
7. Implement Owner branding, staff roles, user dashboard and moderation controls.
8. Add backups/restore, monitoring, alerting, update/rollback, penetration tests and disaster recovery.
9. Run staging acceptance tests before enabling paid production workloads.

## Security baseline

- Use an unprivileged service account; avoid running the web application as root.
- Store secrets in a root-owned environment file or secret manager. Do not commit `.env`.
- Use Argon2id (or an appropriately configured modern password hash), secure HTTP-only cookies, CSRF protection, rate limiting and MFA for privileged accounts.
- Require TLS for panel and agent traffic. Prefer mTLS or short-lived signed agent credentials.
- Enforce authorization server-side on every request. Never rely on hidden buttons for access control.
- Use an append-only audit trail for Owner/staff actions.
- Treat all uploaded mods, plugins, templates and ISO images as untrusted.
- Payment webhook handlers must verify signatures, deduplicate events and reconcile provider state.
- Never collect or store raw card data. Use hosted checkout from a supported payment provider.
- Do not expose Docker socket or libvirt management APIs to customers or the public internet.
- Apply explicit CPU, RAM, disk, process, bandwidth and port limits. “Unlimited” plans must still be bounded by physical capacity and fair-use rules.

## Domain and TLS

Choose any domain you control. Create an A/AAAA record for the panel hostname pointing to the panel VPS. If nodes are separately addressed, configure their DNS independently. The future production installer must verify DNS and obtain TLS certificates only after explicit operator confirmation. Do not use a placeholder domain in production.

## License

Choose a license before publishing implementation code. This specification does not grant rights to third-party dependencies or images.
