class ReplaceAgeColumnInApplicants < ActiveRecord::Migration[7.0]
  def change
    remove_column :applicants, :age
    add_column :applicants, :birth_date, :datetime
  end
end
