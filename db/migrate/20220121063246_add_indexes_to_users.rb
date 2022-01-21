class AddIndexesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :admins, :user, foreign_key:true
    add_reference :applicants, :user, foreign_key:true
    add_reference :agencies, :user, foreign_key:true
  end
end
