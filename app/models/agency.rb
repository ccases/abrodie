class Agency < ApplicationRecord
  belongs_to :user
  has_many :applicants, through: :reviews
  has_many :branches
  has_many :jobs
end
