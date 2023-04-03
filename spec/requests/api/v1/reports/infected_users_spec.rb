require 'rails_helper'

RSpec.describe "/api/v1/reports/infected_users", type: :request do
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      get api_v1_reports_infected_users_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it "returns the report attributes" do
      get api_v1_reports_infected_users_url, headers: valid_headers, as: :json
      expect(response.body).to_be eq({ porcentagem_usuarios_infectados: 1 })
    end
  end
end
