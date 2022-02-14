class Applicant < ApplicationRecord
  belongs_to :user
  has_many :agencies, through: :reviews
  has_many :jobs, through: :applications
  has_many :applications

  has_one_attached :resume_file

  validates :fname, :lname, presence: true

  private



end
