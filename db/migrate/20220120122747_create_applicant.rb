class CreateApplicant < ActiveRecord::Migration[7.0]
  def change
    create_table :applicants do |t|
      t.string :specialization
      t.text :resume
      t.string :educational_level
      t.integer :age
      t.float :experience
      t.string :fname
      t.string :lname

      t.timestamps
    end
  end
end
