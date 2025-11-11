class AddGenderAndVaccinatedToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :gender, :string
    add_column :patients, :vaccinated, :boolean
  end
end
