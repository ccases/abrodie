class PagesController < ApplicationController
  # skip_before_action :authenticate_user!

  def index
    if current_user
      redirect_to dashboard_path
    end
  end

  def dashboard
    redirect_to root_path unless current_user
  end

  def guidelines
  end
end
