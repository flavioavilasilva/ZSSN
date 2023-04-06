# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/users/1/items', type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      user = create(:user)
      create(:item, user:)

      get api_v1_user_items_url(user), headers: {}, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      user = create(:user)
      item = create(:item, user:)

      get api_v1_user_item_url(user, item), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Item' do
        user = create(:user)

        expect do
          post api_v1_user_items_url(user),
               params: { name: 'water' }, headers: {}, as: :json
        end.to change(Item, :count).by(1)
      end

      it 'renders a JSON response with the new api_v1_item' do
        user = create(:user)

        post api_v1_user_items_url(user),
             params: { name: 'water' }, headers: {}, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Item' do
        user = create(:user)

        expect do
          post api_v1_user_items_url(user),
               params: { item: { x: 1 } }, as: :json
        end.to change(Item, :count).by(0)
      end

      it 'renders a JSON response with errors for the new api_v1_item' do
        user = create(:user)
        post api_v1_user_items_url(user),
             params: { item: { x: 1 } }, headers: {}, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested api_v1_item' do
      user = create(:user)
      item = create(:item, user:)

      expect do
        delete api_v1_user_item_url(user, item), headers: {}, as: :json
      end.to change(Item, :count).by(-1)
    end
  end
end
