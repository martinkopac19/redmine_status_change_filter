class AddLastStatusChangedOnToIssues < ActiveRecord::Migration[6.1]
  def up
    unless column_exists?(:issues, :last_status_changed_on)
      add_column :issues, :last_status_changed_on, :datetime
      add_index  :issues, :last_status_changed_on
    end
    # backfill: posledná zmena stavu z journalov; ak žiadna, dátum vytvorenia
    execute <<-SQL.squish
      UPDATE issues SET last_status_changed_on = COALESCE(
        (SELECT MAX(j.created_on)
           FROM journals j
           JOIN journal_details d ON d.journal_id = j.id
            AND d.property = 'attr' AND d.prop_key = 'status_id'
          WHERE j.journalized_type = 'Issue' AND j.journalized_id = issues.id),
        issues.created_on)
    SQL
  end

  def down
    remove_column :issues, :last_status_changed_on if column_exists?(:issues, :last_status_changed_on)
  end
end
