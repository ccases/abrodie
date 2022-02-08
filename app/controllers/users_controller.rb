class UsersController < ApplicationController
  before_action :set_user, only: %i[ show applicant? agency? admin? ]
  def index
    @users = User.all
  end

  def show
    if admin?
      @admin = @user.admin
    elsif agency?
      @agency = @user.agency
      if @agency.average_rating.nil?
        @rating = 0
      else
        @rating = @agency.average_rating
        @reviews = @agency.reviews
      end
    elsif applicant?
      @applicant = @user.applicant
    end
  end

  def update
    if admin?
      @admin = @user.admin
    elsif agency?
      @agency = @user.agency
    elsif applicant?
      @applicant = @user.applicant
    end

  end

  private
  
  def admin?
    @user&.admin
  end

  def agency?
    @user&.agency
  end

  def applicant?
    @user&.applicant
  end

  def set_user
    @user = User.find(params[:id])
  end

end
