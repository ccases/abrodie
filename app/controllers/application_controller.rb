class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  def authenticate_admin!
    render status: :forbidden if current_user.admin.nil?
  end
  def authenticate_agency!
    render status: :forbidden if current_user.agency.nil?
  end
  def authenticate_applicant!
    render status: :forbidden if current_user.applicant.nil?
  end

end
