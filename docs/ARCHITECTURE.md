# Architecture

```text
Browser
  │ HTTPS
  ▼
Reverse proxy / TLS
  │
  ▼
Independent PiratesNodes API ─── PostgreSQL
  │                              Redis / job queue
  ├── Identity + RBAC
  ├── Plans + invoices
  ├── Owner branding
  └── Provisioning scheduler
             │ authenticated, signed jobs
       ┌─────┴──────────┐
       ▼                ▼
Game node agent     KVM compute agent
       │                │
  isolated game      libvirt/KVM
  containers         tenant VMs

Optional integrations: payment provider, mail provider, Discord bot.
```

## Boundaries
- Panel API owns identities, plans, billing state and desired service state.
- Node agent owns local execution and reports observed state.
- The database is not shared with Pterodactyl.
- The panel does not execute arbitrary shell commands from browser input.
- Agent job payloads are typed, bounded, signed/authenticated, expiring and idempotent.
- Payment provider is authoritative for payment status after signature verification and reconciliation.
