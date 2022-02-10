class AgenciesController < ApplicationController
  def index
    @agencies = Agency.all
  end

end
