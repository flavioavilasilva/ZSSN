require 'rails_helper'

RSpec.describe '/api/v1/reports/not_infected_users', type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      get api_v1_reports_not_infected_users_url, headers: {}, as: :json
      expect(response).to be_successful
    end

    it 'call the report and returns the expected key' do
      expect(Reports::NotInfectedUser).to receive(:percentage)

      get api_v1_reports_not_infected_users_url, headers: {}, as: :json

      expect(JSON.parse(response.body).keys).to include('not_infected_users_percentage')
    end
  end
end
