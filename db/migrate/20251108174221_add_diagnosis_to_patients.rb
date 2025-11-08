class AddDiagnosisToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :diagnosis, :text
  end
end
