class JobsController < ApplicationController
  before_action :authenticate_admin_or_agency!, only: [:edit, :create, :destroy]
  before_action :set_job, only: [:edit, :update, :destroy, :show]

  def index
    @jobs = Job.all
  end

  def show
    if current_user&.applicant

      if Application.exists?(applicant_id: current_user.applicant.id, job_id: @job.id)
        @application = Application.find_by(applicant_id: current_user.applicant.id, job_id: @job.id)
      else
        applicant = current_user.applicant
        @application = @job.applications.build(applicant_id: applicant.id)
      end
    else
      @application = nil
    end
  end

  def create
    @job = Job.new(job_params)
    if current_user.admin
      @job.agency_id = params[:job][:agency_id]
    end
    if @job.save
      redirect_to jobs_path, :flash => {:success => "Job added"}
    else
      render :action => "new", :flash => {:error => "Saving unsuccessful"}
    end
  end

  def new
    @job = Job.new
    @categories = @job.categories.build
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to jobs_path, :flash => {:success => "Job updated"}
    else
      render :action => "edit", :flash => {:error => "Saving unsuccessful"}
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path, :flash => {:success => "Job destroyed"}
  end

  def job_search
    if params[:job].present?
      @job = Job.new_search (params[:job])
      if @job
        respond_to do |format|
          format.js { render partial: 'jobs/search_result'}
        end
      else
        respond_to do |format|
          flash[:notice] = 'Please enter another job keyword'
          format.js { render partial: 'jobs/search_result'}
        end
      end
    else
      respond_to do |format|
        flash[:notice] = 'Please enter a job keyword'
        format.js { render partial: 'jobs/search_result'}
      end
    end
  end

  private

  def job_params
    params.require(:job).permit(
      :desc,
      :title,
      :salary,
      :level,
      :location,
      :salary_hidden,
      :vacancies,
      :vacancies_hidden,
      :employer,
      :agency_id,
      categories_attributes: [
        :name,
        :description
      ]
    )
  end

  def set_job
    @job = Job.find(params[:id])
  end

end
