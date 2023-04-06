# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/barters', type: :request do
  describe 'POST /create' do
    context 'with valid parameters' do
      it 'call the barter service' do
        allow_any_instance_of(Barter).to receive(:valid?).and_return(true)

        expect_any_instance_of(BarterService).to receive(:call).and_return(true)
        post api_v1_barters_url,
             params: { barter: { given_items: {}, receiven_items: {} } }, headers: {}, as: :json
      end

      it 'renders a JSON response with the new api_v1_barter' do
        allow_any_instance_of(Barter).to receive(:valid?).and_return(true)
        allow_any_instance_of(BarterService).to receive(:call).and_return(true)

        post api_v1_barters_url,
             params: { barter: { given_items: {}, receiven_items: {} } }, headers: {}, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not call the barter service' do
        post api_v1_barters_url,
             params: { barter: { given_items: {}, receiven_items: {} } }, headers: {}, as: :json

        expect_any_instance_of(BarterService).to_not receive(:call)
      end

      it 'renders a JSON response with errors for the new api_v1_barter' do
        allow_any_instance_of(Barter).to receive(:valid?).and_return(false)

        post api_v1_barters_url,
             params: { barter: { given_items: {}, receiven_items: {} } }, headers: {}, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end
end
