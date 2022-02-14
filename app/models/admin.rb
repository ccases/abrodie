class Admin < ApplicationRecord
  belongs_to :user

  validates :fname, :lname, :contact_no, presence: true
end
