class ApplicantsController < ApplicationController
  before_action :set_applicant, only: %i[update]
  def update
    @applicant.update!(applicant_params)
  end


  private

  def set_applicant
    @applicant = Applicant.find(params[:id])
  end

  def applicant_params
    params.require(:applicant).permit(:resume_file)
  end
end