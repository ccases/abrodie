class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :applicant, dependent: :destroy
  has_one :agency, dependent: :destroy
  has_one :admin, dependent: :destroy

  has_and_belongs_to_many :rooms
  has_many :messages

  accepts_nested_attributes_for :applicant, :agency, :admin

  after_create :create_drafts

  def create_drafts
    self.rooms.create!(name: "drafts_#{self.id}")
  end
end
