require "rails_helper"

RSpec.describe Api::V1::Reports::AverageOfItemsByUsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/reports/average_of_items_by_users").to route_to("api/v1/reports/average_of_items_by_users#index")
    end
  end
end
