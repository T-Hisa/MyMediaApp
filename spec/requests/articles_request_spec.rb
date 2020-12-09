require 'rails_helper'

RSpec.describe "Articles", type: :request do

  describe "GET root_path" do
    context "confirm around http request" do
      it "returns http status 301" do
        get root_path
        expect(response).to have_http_status(301)
      end 
      
      it "response body has articles" do
        get root_path
        expect(response.body).to 
      end
    end
  end

  describe "GET /index" do
    # context "cofirm http request"
    it "returns http success" do
      get articles_path
      expect(response).to have_http_status(:success)
    end
  end

  describe

end
