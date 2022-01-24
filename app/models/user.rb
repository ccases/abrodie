class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :applicant
  has_one :agency
  has_one :admin

  accepts_nested_attributes_for :applicant, :agency, :admin

  before_save :create_profile

  def create_profile
    if self.applicant

    elsif self.agency

    elsif self.admin

    end
  end
end
