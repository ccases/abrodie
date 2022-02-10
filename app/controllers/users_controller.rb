class UsersController < ApplicationController
  before_action :set_user, only: %i[ show applicant? agency? admin? ]
  def index
    @users = User.all
  end

  def new
    @user = User.new
    if(params[:user_type] == "applicant")
      @applicant = @user.build_applicant
    elsif(params[:user_type] == "agency")
      @agency = @user.build_agency
    elsif(params[:user_type] == "admin")
      @admin = @user.build_admin
    end
  end

  def edit
    @user=User.find(params[:id])
    
  end

  def show
    if admin?
      @admin = @user.admin
    elsif agency?
      @agency = @user.agency
      @rating = @agency.average_rating
      @reviews = @agency.reviews
    elsif applicant?
      @applicant = @user.applicant
    end
  end

  def create
    @user=User.create(user_params)
    if @user.save
      redirect_to @user
    else
      render :action => 'new'
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

    if @user.update(user_params)
      sign_in(@user, :bypass => true) if @user == current_user
      redirect_to @user
    else
      render action: "edit"
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

  def user_params
    if params[:user][:applicant_attributes]
      params.require(:user).permit(:email, :password, :password_confirmation, applicant_attributes: [:fname, :lname, :resume_file, :birth_date, :specialization, :educational_level, :experience])
    elsif params[:user][:agency_attributes]
      params.require(:user).permit(:email, :password, :password_confirmation, agency_attributes: [:name, :kind, :license_validity, :contact_no, :address, :bio])
    elsif params[:user][:admin_attributes]
      params.require(:user).permit(:email, :password, :password_confirmation, admin_attributes: [:fname, :lname, :contact_no])
    end
  end

end
