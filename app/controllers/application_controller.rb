class ApplicationController < ActionController::Base
  # devise_group :user, contains: [:applicant, :agency, :admin]
  before_action :authenticate_user!, only: %i[ authenticate_admin! authenticate_agency! authenticate_applicant! authenticate_admin_or_agency!]
  
  def authenticate_admin!
    render status: :forbidden if current_user.admin.nil?
  end
  def authenticate_agency!
    render status: :forbidden if current_user.agency.nil?
  end
  def authenticate_applicant!
    render status: :forbidden if current_user.applicant.nil?
  end
  def authenticate_admin_or_agency!
    if current_user.admin
      return
    elsif current_user.agency
      return
    else
      render status: :forbidden
    end
  end

  protected

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

end
