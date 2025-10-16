class Patient < ApplicationRecord

    
  def self.ransackable_attributes(auth_object = nil)
    ["name", "diagnosis", "age", "admitted_on", "created_at", "updated_at", "id"]
  end

  # Whitelist searchable associations (empty for now)
  def self.ransackable_associations(auth_object = nil)
    []
  end




end
