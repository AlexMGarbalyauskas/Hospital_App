class AddDeathAndCureDetailsToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :date_of_death, :date
    add_column :patients, :death_reason, :string
    add_column :patients, :date_of_cure, :date
    add_column :patients, :cure_reason, :string
  end
end
