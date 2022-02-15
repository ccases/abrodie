class JobsController < ApplicationController
  before_action :authenticate_admin_or_agency!, only: [:edit, :create]
  before_action :set_job, only: [:edit, :update, :destroy, :show]

  def index
    if params[:agency_id]
      @jobs = Agency.find(params[:agency_id]).jobs
    else
      @jobs = Job.all
    end
  end

  def show
    res = ForexApi::Client.convert_to(@job.location, @job.salary)
    @currency = ForexApi::Client.find_currency(@job.location)
    @converted = res[:data]["converted_amount"]
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

  # if job is present show result, else show all jobs available
  def job_search
    if params[:job].present?
      @job = Job.search (params[:search]).downcase
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

  def search_result
    if params[:search].present?
      @job = params[:search].downcase
      @results = Job.all.where("lower(title) LIKE :search", search:"%#{@job}%")
    else
      @results = Job.all 
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
