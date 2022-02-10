class ApplicationsController < ApplicationController
    def index
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
