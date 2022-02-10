class ApplicationsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @applications = current_user.applicant.applications

        @applications = Agency.find(params[:id]).applications

    end

    def show
    end

    def create
    end

    def destroy
    end

    def update 
    end

    def applications_params
    end

    def set_applications
    end

end
