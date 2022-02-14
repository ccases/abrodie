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

  def edit
    if resource&.applicant
      @applicant = resource.applicant
    elsif resource&.agency
      @agency = resource.agency
    elsif resource&.admin
      @admin = resource.admin
    end
  end

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      if params[:user][:applicant_attributes]
        @applicant = resource.applicant
      elsif params[:user][:agency_attributes]
        @agency = resource.agency
      elsif params[:user][:admin_attributes]
        @admin = resource.admin
      end
      respond_with resource

    end
  end
  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    if params[:user][:applicant_attributes]
      devise_parameter_sanitizer.permit(:sign_up,
        keys: [:avatar, applicant_attributes: [:fname, :lname]])
    elsif params[:user][:agency_attributes]
      devise_parameter_sanitizer.permit(:sign_up, 
        keys: [:avatar, agency_attributes: [:name, :kind]])
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    if params[:user][:applicant_attributes]
      devise_parameter_sanitizer.permit(:sign_up,
        keys: [:avatar, applicant_attributes: [:fname, :lname, :resume_file]])
    elsif params[:user][:agency_attributes]
      devise_parameter_sanitizer.permit(:sign_up, 
        keys: [:avatar, agency_attributes: [:name, :kind]])
    elsif params[:user][:admin_attributes]
      devise_parameter_sanitizer.permit(:sign_up, 
        keys: [:avatar, admin_attributes: [:fname, :lname]])
    end
  end

  def agency?
    params[:user_type] == "agency"
  end
  def applicant?
    params[:user_type] == "applicant"
  end
  def admin?
    params[:user_type] == "admin"
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
    root_path
  end

end
