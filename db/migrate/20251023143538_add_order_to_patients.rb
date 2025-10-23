class AddOrderToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :order, :integer
  end
end
