class CreateAdmin < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :fname
      t.string :lname
      t.string :contact_no

      t.timestamps
    end
  end
end
