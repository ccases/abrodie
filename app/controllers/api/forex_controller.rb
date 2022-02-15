module Api
  class ForexController < ApplicationController
    def convert_to_currency
      # converts PHP to currency
      res = ForexApi::Client.convert_to_currency(params[:currency], params[:amount].to_f)
      render json: res
    end

    def convert_to_country
      # converts PHP to currency of country
      res = ForexApi::Client.convert_to_country(params[:country], params[:amount].to_f)
      render json: res
    end

  end
end