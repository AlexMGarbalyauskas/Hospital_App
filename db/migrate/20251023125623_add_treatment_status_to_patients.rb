class AddTreatmentStatusToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :treatment_status, :string
  end
end
