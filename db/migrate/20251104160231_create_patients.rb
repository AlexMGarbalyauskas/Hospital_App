class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :age
      t.text :diagnosis
      t.string :category
      t.date :addmitted_on
      t.string :age_group
      t.boolean :critical_status
      t.string :profile_pic

      t.timestamps
    end
  end
end
