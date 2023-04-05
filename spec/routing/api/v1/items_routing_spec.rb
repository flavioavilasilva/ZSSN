# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/users/1/items').to route_to('api/v1/items#index', user_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/users/1/items/1').to route_to('api/v1/items#show', user_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/users/1/items').to route_to('api/v1/items#create', user_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/users/1/items/1').to route_to('api/v1/items#update', user_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/v1/users/1/items/1').to route_to('api/v1/items#update', user_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/v1/users/1/items/1').to route_to('api/v1/items#destroy', user_id: '1', id: '1')
    end
  end
end
