class Review < ApplicationRecord
  belongs_to :agency
  belongs_to :applicant

  validates :rating, :body, presence: true

  after_create :update_agency_rating

  def update_agency_rating
    agency = self.agency
    n = agency.reviews.count
    avg = agency.average_rating

    avg = avg + (self.rating - avg)/n
    agency.update!(average_rating: avg)

  end
end


