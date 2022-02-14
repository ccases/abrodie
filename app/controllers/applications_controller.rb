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
        @dumy = 2
        debugger
    end

    def edit

    end

    def create
        authenticate_applicant!
        @job = Job.find(params[:job_id])
        @application = @job.applications.build(:applicant_id => current_user.applicant.id)

        if @application.save
            redirect_to job_path(@job), :flash => {:success => "Successfully applied for the job!"}
        else
            redirect_to job_path(@job), :flash => {:error => "An error has occured."}
        end
    end

    def destroy
        @job = Job.find(params[:job_id])
        @application = @job.applications.find(params[:id])
        @application.destroy
        redirect_to job_path(@job), :flash => {:success => "Removed application for this job."}
    end

    def update

    end

    def update 

    end

    private

    def application_params
        params.require(:application).permit(:applicant_id => current_user.applicant.id)
    end

    def set_applications

    end

end
