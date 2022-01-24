class JobsController < ApplicationController
  before_action :authenticate_admin_or_agency!, only: [:edit, :create, :destroy]
  before_action :set_job, only: [:edit, :update, :destroy]
  def index
    @jobs = Job.all
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to jobs_path, :flash => {:success => "Job added"}
    else
      render :action => "new", :flash => {:error => "Saving unsuccessful"}
    end
  end

  def new
    @job = Job.new
  end

  def edit
  end

  def update
    if @job.update(@job.id, job_params)
      redirect_to jobs_path, :flash => {:success => "Job updated"}
    else
      render :action => "edit", :flash => {:error => "Saving unsuccessful"}
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path, :flash => {:success => "Job destroyed"}
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
      :employer
    )
  end

  def set_job
    @job = Job.find(params[:id])
  end
end
