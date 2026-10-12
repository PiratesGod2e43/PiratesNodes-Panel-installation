# Implementation plan

## Phase 0 — safety and requirements
- Confirm supported Ubuntu LTS release, panel hostname, node hostnames, storage model and network topology.
- Reserve ports and IP ranges without touching Pterodactyl.
- Keep the existing Pterodactyl services, databases, directories, Docker networks and firewall rules unchanged.
- Build and test first in disposable staging VMs.

**Exit gate:** written threat model, port map, backup plan and recovery procedure.

## Phase 1 — foundation
- Backend: choose a maintained framework and pin supported versions.
- PostgreSQL migrations, Redis-backed jobs, structured logs, health/readiness endpoints.
- Authentication, email verification, password reset, MFA for Owner/staff, session revocation.
- RBAC permissions checked by backend middleware/service layer.
- Audit events for role changes, billing adjustments, provisioning, suspensions and branding changes.
- CI: lint, unit/integration tests, dependency scanning, secret scanning and container scanning.

**Exit gate:** no privileged endpoint without authorization tests; backups can be restored in staging.

## Phase 2 — independent node agent
- Agent enrolls through one-time enrollment code or certificate flow.
- Mutual TLS or short-lived signed credentials; credentials can be rotated and revoked.
- Agent accepts only schema-validated, signed, idempotent jobs from the control plane.
- Separate worker queues for game servers and virtual machines.
- Never expose Docker socket/libvirt socket to the panel web process.
- Agent runs with least privilege and narrowly scoped privileged helpers.

**Exit gate:** replay, tampering, revoked credential and compromised-panel threat tests.

## Phase 3 — Minecraft hosting
- Container runtime and versioned allowlist of supported server images.
- Quotas for CPU, RAM, disk, process count, network/ports and server count.
- Provision/start/stop/restart/reinstall, console streaming and scoped file management.
- Backups, restore points, scheduled tasks and usage metrics.
- Plugin/mod installer uses an allowlisted catalog and verifies checksums; arbitrary URL downloads disabled by default.
- Server splitter is deferred until its meaning and data-migration semantics are specified.

**Exit gate:** container escape hardening review, quota tests, restore drill, port-collision tests.

## Phase 4 — KVM VPS hosting
- Separate compute nodes with VT-x/AMD-V enabled and tested KVM support.
- libvirt access only on the host; management channel private and authenticated.
- Verified cloud images, cloud-init, isolated tenant networks, firewall policy and per-plan quotas.
- Provision, power actions, console access, rebuild, resize, snapshot and delete workflows.
- Enforce CPU/RAM/storage/IP capacity. No “unlimited” allocation beyond physical capacity.
- Do not mount host paths into customer VMs or pass through host management sockets.

**Exit gate:** tenant isolation tests, image integrity checks, quota enforcement and recovery test.

## Phase 5 — plans and billing
- Plan catalog defines product type, price, billing interval, quotas, features and availability.
- Free plans use explicit quotas and abuse controls.
- Paid plan entitlements derive from verified billing state, not client-supplied flags.
- Invoice ledger records immutable financial events; corrections use adjustment entries.
- Payment provider integration via hosted checkout; webhook signature verification, event deduplication, retries and reconciliation.
- QR payments only through a provider that officially supports them; never trust a screenshot or client redirect as proof of payment.
- Suspend on policy-defined overdue state; unsuspend only after reconciliation. Provide manual audited override.

**Exit gate:** duplicate/out-of-order webhook tests, refund/chargeback handling and invoice reconciliation.

## Phase 6 — Owner, staff and user experience
- Owner: brand name, logo, favicon, theme tokens, support links, legal links, public domain settings.
- Logo uploads: MIME sniffing, size limits, raster/SVG sanitization policy, storage outside executable web roots.
- Roles: Owner, Admin, Billing, Support, Moderator, User; least privilege by default.
- Owner can grant permissions, but high-risk actions require re-authentication and audit events.
- User dashboard shows services, quota, usage, invoices, support and security sessions.
- Staff cannot access secrets or payment credentials by default.

**Exit gate:** permission matrix tests and tenant-boundary tests.

## Phase 7 — release and operations
- Signed release artifacts, pinned dependencies, migration dry-runs, database backup before update, health checks and rollback.
- TLS, security headers, rate limits, alerting, log retention, incident response and abuse process.
- Runbook for restore, node loss, key rotation, billing reconciliation and compromised account.
- Independent security review and staging soak test before production.

## Deployment safety gates
A future production installer must:
1. Detect unsupported OS and insufficient disk/RAM.
2. Require explicit domain confirmation and successful DNS checks.
3. Check for port/service conflicts and stop rather than overwrite.
4. Use dedicated service users, restrictive file permissions and generated secrets.
5. Back up any existing target files before modifying them.
6. Never inspect, alter, stop or reuse Pterodactyl resources automatically.
7. Require a clear operator confirmation before firewall or network changes.
8. Verify health checks and provide rollback instructions.
