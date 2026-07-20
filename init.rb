# Redmine Status Change Filter
# Pridá do issues filter (a stĺpec) "Posledná zmena stavu" — dátum poslednej
# zmeny STAVU tasku (nie akejkoľvek úpravy/komentára). Bez zásahu do jadra:
# reálny udržiavaný stĺpec issues.last_status_changed_on + prepend patche.

require_relative 'lib/status_change_filter/issue_patch'
require_relative 'lib/status_change_filter/issue_query_patch'

Redmine::Plugin.register :redmine_status_change_filter do
  name 'Redmine Status Change Filter'
  author 'Martin Kopáč'
  description 'Adds an issue filter/column for the date of the last status change (not any update).'
  version '0.1.0'
  url 'https://github.com/martinkopac19/redmine_status_change_filter'
  requires_redmine version_or_higher: '5.0'
end

# Patch priamo pri načítaní (klon beží v produkcii bez reloadu)
Issue.prepend(StatusChangeFilter::IssuePatch)      unless Issue.included_modules.include?(StatusChangeFilter::IssuePatch)
IssueQuery.prepend(StatusChangeFilter::IssueQueryPatch) unless IssueQuery.included_modules.include?(StatusChangeFilter::IssueQueryPatch)
