# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super do |resource|
      if applicant?
        @applicant = resource.build_applicant
      elsif agency?
        @agency = resource.build_agency
      elsif admin?
        @admin = resource.build_admin
      end
    end
  end

  # POST /resource
  def create
    super do |resource|
      if params[:applicant_attributes]
        user_new = resource.create_applicant!(params[:applicant])
      elsif params[:agency_attributes]
        user_new = resource.create_agency!(params[:agency])
      elsif params[:admin_attributes]
        user_new = resource.create_agency!(params[:admin])
      end

      if resource.save
        redirect_to root_path, notice: 'welcome welcome'
      else
      end
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    if applicant?
      devise_parameter_sanitizer.permit(:sign_up,
        keys: [applicant_attributes: [:fname, :lname]])
    elsif agency?
      devise_parameter_sanitizer.permit(:sign_up,
        keys: [agency_attributes: [:name, :kind]])
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  def agency?
    request.original_url.include? "agency"
  end
  def applicant?
    request.original_url.include? "applicant"
  end
  def admin?
    request.original_url.include? "admin"
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
    root_path
  end

  def sign_up_params
    if agency?
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        agency_attributes: [
          :kind,
          :name
        ]
      )
    elsif applicant?
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        applicant_attributes: [
          :fname,
          :lname
        ]
      )
    elsif admin?
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        admin_attributes: [
          :fname,
          :lname
        ]
      )
    end
  end

  def account_update_params 
    if agency?
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        agency_attributes: [
          :kind,
          :name
        ]
      )
    elsif applicant?
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        applicant_attributes: [
          :fname,
          :lname
        ]
      )
    elsif admin?
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        admin_attributes: [
          :fname,
          :lname
        ]
      )
    end
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
