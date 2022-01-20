class CreateApplication < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.float :expected_salary
      t.string :status, default: "processing" # can be maybe "for interview", "denied", "accepted"
      t.text :resume

      t.timestamps
    end
  end
end
