module StatusChangeFilter
  module IssueQueryPatch
    # Filter "Posledná zmena stavu" — dátum (date_past). Keďže je to reálny
    # stĺpec issues.last_status_changed_on, generický Query#sql_for_field zvládne
    # všetky dátumové operátory (po/pred dátumom, medzi, viac ako N dní dozadu…).
    def initialize_available_filters
      super
      add_available_filter 'last_status_changed_on',
                           type: :date_past,
                           name: l(:field_last_status_changed_on)
    end

    # Umožní stĺpec aj zobraziť a zoradiť vo výpise issues.
    def available_columns
      cols = super
      unless cols.any? { |c| c.name == :last_status_changed_on }
        cols << QueryColumn.new(:last_status_changed_on,
                                sortable: "#{Issue.table_name}.last_status_changed_on",
                                caption: :field_last_status_changed_on)
      end
      cols
    end
  end
end
