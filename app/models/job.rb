class Job < ApplicationRecord
  belongs_to :agency
  has_many :applicants, through: :applications
  has_many :applications
  has_and_belongs_to_many :categories

  accepts_nested_attributes_for :applications
  accepts_nested_attributes_for :categories
end
