class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :applicant, dependent: :destroy
  has_one :agency, dependent: :destroy
  has_one :admin, dependent: :destroy

  accepts_nested_attributes_for :applicant, :agency, :admin

  before_save :create_profile

  def create_profile
    if self.applicant

    elsif self.agency

    elsif self.admin

    end
  end
end
