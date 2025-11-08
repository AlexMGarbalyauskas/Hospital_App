class AddTreatmentDetailsToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :treatment_date, :date
    add_column :patients, :treatment_reason, :text
  end
end
