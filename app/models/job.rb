class Job < ApplicationRecord
  belongs_to :agency
  has_many :applicants, through: :applications
  has_and_belongs_to_many :categories
end
