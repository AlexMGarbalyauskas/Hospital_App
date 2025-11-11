class AddFuzerxTokenToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :fuzerx_token, :string
  end
end
