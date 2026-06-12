# CHANGE LOG

**Version (0.0.9)**
- udpate to ruby 4.0.x
  - needed to update vcr (5.1) gem to (6.4.0)
- update gems to fix high security issues (bundle-audit --update)
  - **addressable (2.8.1)** - ISSUE: CVE-2026-35611; SOLUTION: update to '>= 2.9.0'
  - **rexml (3.2.5)** - ISSUE(S): CVE-2024-35176, CVE-2024-39908, CVE-2024-41123, CVE-2024-41946, CVE-2024-43398, CVE-2024-49761; SOLUTION: update to '>= 3.3.9'
