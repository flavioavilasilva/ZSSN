require 'rails_helper'

RSpec.describe Api::V1::Reports::NotInfectedUsersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/reports/not_infected_users').to route_to('api/v1/reports/not_infected_users#index')
    end
  end
end
