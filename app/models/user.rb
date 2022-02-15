class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :applicant, dependent: :destroy
  has_one :agency, dependent: :destroy
  has_one :admin, dependent: :destroy

  has_one_attached :avatar do |attachable|
    attachable.variant :msg, resize_to_limit: [50,50]
    attachable.variant :sidebar_icon, resize_to_limit: [72, 72]
    attachable.variant :navbar_icon, resize_to_limit: [45, 45]
  end

  validate :correct_avatar_mime_type

  has_and_belongs_to_many :rooms
  has_many :messages

  accepts_nested_attributes_for :applicant, :agency, :admin

  after_create :create_drafts

  def create_drafts
    self.rooms.create!(name: "drafts_#{self.id}")
  end

  private

  def correct_avatar_mime_type
    if avatar.attached? && !avatar.content_type.in?(%w(image/jpeg image/png))
      errors.add(:avatar, 'Must be a jpeg/jpg or png file')
    end
  end
end
