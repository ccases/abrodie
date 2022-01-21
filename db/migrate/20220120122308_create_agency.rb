class CreateAgency < ActiveRecord::Migration[7.0]
  def change
    create_table :agencies do |t|
      t.boolean :verified, default: false
      t.string :kind
      t.datetime :license_validity
      t.string :contact_no
      t.string :address
      t.float :average_rating, default: false
      t.string :name

      t.timestamps
    end
  end
end
