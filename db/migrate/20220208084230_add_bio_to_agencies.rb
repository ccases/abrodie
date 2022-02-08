class AddBioToAgencies < ActiveRecord::Migration[7.0]
  def change
    add_column :agencies, :bio, :text
  end
end
