class CreateReview < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :rating, default: 0
      t.text :body
      t.references :applicant, null: false, foreign_key: true
      t.references :agency, null: false, foreign_key: true

      t.timestamps
    end
  end
end
