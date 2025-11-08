class AddDeathDetailsToPatients < ActiveRecord::Migration[7.0]
  def change
    # Only add columns if they don't already exist
    add_column :patients, :reason_of_death, :text unless column_exists?(:patients, :reason_of_death)
  end
end

