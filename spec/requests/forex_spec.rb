require 'rails_helper'

# RSpec.describe 'ArticlesController', type: :request do

#   describe "GET /articles" do
#     it "returns the index page" do
#       get articles_path
#       expect(response).to have_http_status(200)
#     end
#   end

# end

RSpec.describe 'ForexController', type: :request do
  let(:converter) { described_class.new }
  describe "GET /convert_to_currency" do
    it "returns converted currency" do


    end

    it "returns currency not found on incorrect currency" do
    
    end
  end
end
