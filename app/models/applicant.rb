class Applicant < ApplicationRecord
  belongs_to :user
  has_many :agencies, through: :reviews
  has_many :jobs, through: :applications
  has_many :applications

  has_one_attached :resume_file

  validate :correct_resume_file_mime_type
  validates :fname, :lname, presence: true

  private

  def correct_resume_file_mime_type
    if resume_file.attached? && !resume_file.content_type.in?(%w(application/msword application/pdf))
      errors.add(:resume_file, 'Must be a docx/doc or pdf file')
    end
  end

end
