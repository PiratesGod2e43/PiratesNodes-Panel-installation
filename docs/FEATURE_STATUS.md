# Feature status matrix

Status definitions:
- **Implemented**: code exists and has automated tests for the advertised behavior.
- **Partial**: only a limited piece exists; do not rely on it for production.
- **Placeholder / planned**: design only, interface contract only, or deliberately disabled.

| Capability | Status in this package | Production acceptance requirement |
|---|---|---|
| Product architecture/specification | Implemented as documentation | Review and approve architecture |
| Preflight installer guard | Partial | Test on supported clean Ubuntu images; deployment still absent |
| Independent panel frontend | Placeholder | Build UI and accessibility/security tests |
| REST API | Placeholder | Auth, schema validation, rate limits, versioning, tests |
| Database schema/migrations | Placeholder | Migrations, constraints, backup/restore tests |
| Authentication/session management | Placeholder | Secure sessions, reset flows, MFA, brute-force controls |
| Owner branding (name, logo, colors, links, domain) | Planned | Validated settings, safe image uploads, audit trail |
| Roles and permissions | Specification only | Server-side RBAC/permission tests |
| Free and paid plans | Specification only | Entitlements, quotas, lifecycle tests |
| Billing/invoices | Placeholder | Tax/rounding rules, idempotency, reconciliation |
| Payment gateway/QR checkout | Placeholder | Provider adapter, verified webhook, replay tests; no raw card storage |
| Minecraft provisioning | Placeholder | Isolated containers, quotas, image allowlist, port allocator |
| Minecraft console/files/backups | Placeholder | Scoped access, safe file operations, restore tests |
| Plugin/mod installer | Placeholder | Trusted catalog/allowlist, malware policy, checksums and rollback |
| KVM/libvirt VPS provisioning | Placeholder | Dedicated compute node, image verification, quotas, network isolation |
| Node agent and secure enrollment | Placeholder | mTLS/short-lived tokens, signed jobs, replay protection, revocation |
| Discord bot | Placeholder | Least-privilege bot, signed callbacks, explicit linking |
| Suspend/unsuspend | Specification only | Billing-state reconciliation and reversible idempotent action |
| Server splitter | Placeholder | Define semantics first; never promise automatic splitting of arbitrary servers |
| Audit log | Planned | Tamper-resistant event trail and retention policy |
| Monitoring/alerts | Placeholder | Metrics, logs, alert routing, health checks |
| Backup/restore and disaster recovery | Placeholder | Tested restore drills and documented RPO/RTO |
| Pterodactyl coexistence safety | Documented constraint | No shared DB/schema, files, service names, ports or network mutation |

**Do not advertise a row as implemented until its acceptance requirements pass.**
