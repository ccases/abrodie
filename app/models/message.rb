class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :body, presence: true

  # broadcasts_to :room

  
  after_create_commit { broadcast_append_to(room) }
  after_destroy_commit { broadcast_remove_to(room) }
end
