class ApplicationsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        if current_user.applicant
            @applications = current_user.applicant.applications
        elsif current_user.agency
            @applications = current_user.agency.applications
        end
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
