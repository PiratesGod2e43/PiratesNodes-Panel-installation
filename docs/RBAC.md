# Role and permission baseline

| Action | Owner | Admin | Billing | Support | Moderator | User |
|---|---:|---:|---:|---:|---:|---:|
| Change global brand/domain | Yes | No by default | No | No | No | No |
| Grant/revoke roles | Yes | Limited delegated roles | No | No | No | No |
| Manage nodes | Yes | Yes | No | Read-only health | No | No |
| View/edit invoices | Yes | Read-only by default | Yes | Limited read | No | Own invoices |
| Provision/delete services | Yes | Yes | No | Limited support flow | No | Own services within plan |
| Suspend/unsuspend | Yes | Yes, audited | Billing-triggered only | Request/limited | No | No |
| Moderate accounts | Yes | Yes | No | Limited | Yes | No |
| View secrets/payment credentials | Restricted break-glass only | No | No | No | No | No |
| Change own profile/security | Yes | Yes | Yes | Yes | Yes | Yes |

Implement permissions as named capabilities and check them on every API operation. UI visibility is not authorization. Add re-authentication for destructive or security-sensitive actions and log actor, target, reason, timestamp and request ID.
