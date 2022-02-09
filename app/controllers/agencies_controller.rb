class AgenciesController < ApplicationController
  def index
    @agencies = Agency.all
  end

  def destroy
    authenticate_admin!
    @agency = User.find_by(agency_id: params[:id])
    @agency.destroy
    redirect_to admin_users_path(user_type: "agency"), flash: {success: "Agency destroyed"}
  end
end
