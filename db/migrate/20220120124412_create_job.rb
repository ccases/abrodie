class CreateJob < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.text :desc
      t.string :title
      t.float :salary
      t.string :level
      t.string :location
      t.boolean :salary_hidden, default: true
      t.integer :vacancies, default: 1
      t.boolean :vacancies_hidden, default: true
      t.string :employer

      t.references :agency
      
      t.timestamps
    end
  end
end
