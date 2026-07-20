# Changelog

## 0.1.0 — 2026-07-20
- Initial release.
- "Last status change" issue filter (date) and list column.
- Maintained via an indexed `issues.last_status_changed_on` column, backfilled
  on install and updated automatically on every status change.
- No core changes; tested on Redmine 6.1.3.
