class AddDetailsToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :critical_status, :string
    add_column :patients, :treatment_time, :string
  end
end
