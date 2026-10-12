#!/usr/bin/env bash
# PiratesNodes preflight-only installer scaffold.
# Intentionally does not install packages or alter services/firewalls.
set -Eeuo pipefail
umask 077

fail() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }
note() { printf '[PiratesNodes preflight] %s\n' "$*"; }

[[ ${EUID:-$(id -u)} -eq 0 ]] || fail "Run with sudo: sudo bash install.sh"
[[ -f .env ]] || fail "Missing .env. Copy .env.example to .env and configure it first."
[[ -f README.md && -d docs ]] || fail "Run this script from the repository root."
command -v bash >/dev/null || fail "bash is required."
command -v awk >/dev/null || fail "awk is required."

# Do not source .env as shell code; parse only the known domain field.
domain="$(awk -F= '$1=="PANEL_DOMAIN" {sub(/^[^=]*=/,""); print; exit}' .env)"
[[ -n "$domain" ]] || fail "PANEL_DOMAIN is empty."
[[ "$domain" != *"example.com"* && "$domain" != *"REPLACE"* ]] || fail "Replace placeholder values in .env."
[[ "$domain" =~ ^[A-Za-z0-9.-]+$ ]] || fail "PANEL_DOMAIN must be a hostname (no scheme, path, or spaces)."

if grep -Eq '^(APP_SECRET|DATABASE_URL)=.*(REPLACE|CHANGE_ME|YOUR_)' .env; then
  fail "Replace placeholder secrets/database credentials in .env."
fi
if grep -Eq '^(APP_SECRET)=.{0,31}$' .env; then
  fail "APP_SECRET must be at least 32 characters."
fi

note "Configuration shape looks plausible for $domain."
note "This repository package is a specification/scaffold, not a deployable application."
note "No packages, users, services, firewall rules, databases, DNS, TLS, or Pterodactyl files were changed."
note "Read docs/IMPLEMENTATION_PLAN.md and docs/FEATURE_STATUS.md before implementing deployment."
exit 0
