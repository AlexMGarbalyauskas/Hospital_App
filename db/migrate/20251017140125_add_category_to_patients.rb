class AddCategoryToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :category, :string
  end
end
