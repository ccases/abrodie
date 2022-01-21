class Review < ApplicationRecord
  belongs_to :agency
  belongs_to :applicant
end
