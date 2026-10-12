#!/usr/bin/env bash
# Node setup is not implemented. Safe guard against accidental privileged changes.
set -Eeuo pipefail
printf '%s\n' \
  "PiratesNodes node-agent installer is a placeholder and makes no system changes." \
  "Do not run this on a production node yet." \
  "The production implementation must use explicit node enrollment, short-lived credentials," \
  "least privilege, resource isolation, and a documented uninstall/rollback path."
exit 2
