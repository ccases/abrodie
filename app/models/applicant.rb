class Applicant < ApplicationRecord
  belongs_to :user
  has_many :agencies, through: :reviews
  has_many :jobs, through: :applications

  has_one_attached :resume_file
end
