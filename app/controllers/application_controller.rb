class ApplicationController < ActionController::Base
  # devise_group :user, contains: [:applicant, :agency, :admin]
  before_action :authenticate_user!, only: %i[ authenticate_admin! authenticate_agency! authenticate_applicant! authenticate_admin_or_agency!]
  
  def default_url_options
    if Rails.env.production?
      {:host => ENV.fetch("WEBSITE_URL")}
    else 
      {:host => "localhost", :port => "3000"}
    end
  end

  def authenticate_admin!
    render status: :forbidden if current_user&.admin.nil?
  end
  def authenticate_agency!
    render status: :forbidden if current_user&.agency.nil?
  end
  def authenticate_applicant!
    render status: :forbidden if current_user&.applicant.nil?
  end
  def authenticate_admin_or_agency!
    if current_user&.admin
    elsif current_user&.agency
    else
      render status: :forbidden
    end
  end

  def build_user_child
    if @user.applicant
      @applicant = @user.applicant.build
    elsif @user.agency
      @agency = @user.agency.build
    elsif @user.admin
      @admin = @user.admin.build
    end
  end
  protected

  def after_sign_in_path_for(resource)
    if current_user.applicant
      guidelines_path
    elsif current_user.admin
      admin_users_path("agency")
    elsif current_user.agency
      user_path(current_user)
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

end
