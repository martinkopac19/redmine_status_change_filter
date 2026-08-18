# Redmine Status Change Filter

Adds an issue filter (and list column) for the **date of the last status change**
— i.e. when the issue's *status* was last changed, ignoring comments and other
edits.

Redmine ships with "Updated" (any change, including comments) and "Updated by"
(a person). Neither answers "which tasks haven't changed status in N days" or
"which tasks changed status since a date". This plugin adds exactly that.

## Features

- New date filter **"Last status change"** (`date_past` type) — supports all the
  usual date operators: on/after/before a date, between, today, last N days,
  **more than N days ago** (great for finding stuck tasks), etc.
- New sortable/displayable column **"Last status change"**.
- Backed by a real, indexed column (`issues.last_status_changed_on`) that is
  backfilled from history on install and kept up to date automatically whenever
  an issue's status changes.

## How it works (upgrade-safe)

- A plugin migration adds `issues.last_status_changed_on` (additive; Redmine
  core ignores extra columns, so upgrades are unaffected).
- The column is maintained via a small `Issue` `after_save` hook (`prepend`, no
  core file changes) and exposed through an `IssueQuery` `prepend` patch.
- No Redmine core files are modified, so `git pull` upgrades of Redmine stay
  clean.

## Compatibility

Tested on **Redmine 6.1.3**. Declares `requires_redmine version_or_higher: '5.0'`.

## Installation

```bash
cd /path/to/redmine/plugins
git clone https://github.com/martinkopac19/redmine_status_change_filter.git
cd /path/to/redmine
bundle exec rake redmine:plugins:migrate RAILS_ENV=production
# restart Redmine
```

The migration backfills `last_status_changed_on` for all existing issues from
their journals (falling back to the creation date for issues that never had a
status change).

## Uninstall

```bash
cd /path/to/redmine
bundle exec rake redmine:plugins:migrate NAME=redmine_status_change_filter VERSION=0 RAILS_ENV=production
rm -rf plugins/redmine_status_change_filter
# restart Redmine
```

## License

Copyright (C) 2026 Martin Kopáč

GPL-2.0-or-later, matching Redmine. See [LICENSE](LICENSE).
