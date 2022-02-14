class Agency < ApplicationRecord
  belongs_to :user
  has_many :applicants, through: :reviews
  has_many :branches
  has_many :jobs
  has_many :reviews
  has_many :applications, through: :jobs


  validates :name, :address, :contact_no, presence: true

  
end
