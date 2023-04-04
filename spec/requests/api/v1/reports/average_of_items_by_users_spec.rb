require 'rails_helper'

RSpec.describe "/api/v1/reports/average_of_items_by_users", type: :request do
  describe "GET /index" do
    it "renders a successful response" do
      get api_v1_reports_average_of_items_by_users_url, headers: {}, as: :json
      expect(response).to be_successful
    end

    it "call the report and returns the expected key" do
      expect(Reports::AverageOfItemsByUser).to receive(:items)

      get api_v1_reports_average_of_items_by_users_url, headers: {}, as: :json
      
      expect(JSON.parse(response.body).keys).to include("items")
    end
  end
end
