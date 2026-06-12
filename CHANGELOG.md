# CHANGE LOG

**Version (0.0.9)**
- udpate to ruby 4.0.x
  - needed to update vcr (5.1) gem to (6.4.0) to be ruby 4.0 compatible
- update gems to fix high security issues (bundle-audit --update)
  - **addressable (2.7.0)** - ISSUE: CVE-2021-32740 (High), CVE-2026-35611 (High); SOLUTION: update to '>= 2.9.0'
  - **httparty (0.18.0)** - ISSUE(S): CVE-2024-22049 (Medium), CVE-2025-68696 (High); SOLUTION: update to '>= 0.24.0'
  - **thor (1.0.1)** - ISSUE:  CVE-2025-54314; SOLUTION: update to '>= 1.4.0'
