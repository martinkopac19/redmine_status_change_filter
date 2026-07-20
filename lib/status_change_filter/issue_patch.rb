module StatusChangeFilter
  # Udržiava issues.last_status_changed_on: pri každej zmene stavu (aj pri
  # vytvorení issue, kde sa stav prvýkrát nastaví) zapíše čas zmeny.
  module IssuePatch
    def self.prepended(base)
      base.after_save :scf_update_last_status_changed_on
    end

    def scf_update_last_status_changed_on
      return unless saved_change_to_status_id?
      ts = updated_on || Time.current
      # update_column: priamy zápis do DB bez ďalších callbackov (žiadna rekurzia)
      update_column(:last_status_changed_on, ts)
    end
  end
end
