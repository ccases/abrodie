class CreateBranch < ActiveRecord::Migration[7.0]
  def change
    create_table :branches do |t|
      t.text :location
      t.string :email_ad
      t.string :contact_no
      t.references :agency, null: false, foreign_key: true

      t.timestamps
    end
  end
end
