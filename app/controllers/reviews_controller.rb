class ReviewsController < ApplicationController
  before_action :set_agency, only: %i[new edit create]

  def new
    authenticate_applicant!
    @review = @agency.reviews.build
  end

  def edit
    @review = @agency.reviews.find(params[:id])
  end

  def create
    @review = @agency.reviews.build(review_params)
    if @review.save
      redirect_to user_path(@agency.user)
    else
      @reviews = @agency.reviews
      render 'reviews/new'
    end
  end

  private

  def set_agency
    @agency = Agency.find(params[:agency_id])
  end

  def review_params
    params.require(:review).permit(:body, :rating).merge(applicant_id: current_user.applicant.id)
  end
end
