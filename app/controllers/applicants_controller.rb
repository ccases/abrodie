class ApplicantsController < ApplicationController
  before_action :set_applicant, only: %i[update]
  def update
    if @applicant.update(applicant_params)
      redirect_to user_path(@applicant.user), :flash => {:success => "Applicant updated"}
    else
      redirect_to user_path(@applicant.user), :flash => {:error => "Must be a doc or pdf file"}
    end
  end


  private

  def set_applicant
    @applicant = Applicant.find(params[:id])
  end

  def applicant_params
    params.require(:applicant).permit(:resume_file, :id)
  end
end