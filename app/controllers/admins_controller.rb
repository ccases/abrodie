class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def users
    if params[:user_type]=="agency"
      @agencies = Agency.all
    elsif params[:user_type]=="applicant"
      @applicants = Applicant.all
    elsif params[:user_type]=="admin"
      @admins = Admin.all
    elsif params[:user_type]=="user"
      @users = User.all
    end
  end
end
