class AddLivingStatusToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :living_status, :string
  end
end
