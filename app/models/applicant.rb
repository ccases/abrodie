class Applicant < ApplicationRecord
  belongs_to :user
  has_many :agencies, through: :reviews
  has_many :jobs, through: :applications
end
