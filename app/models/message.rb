class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :body, presence: true

  broadcasts_to :room
end
