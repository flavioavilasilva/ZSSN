require 'rails_helper'

RSpec.describe "/api/v1/users", type: :request do
  describe "GET /index" do
    it "renders a successful response" do
      create(:user)
      get api_v1_users_url, headers: {}, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user = create(:user)
      get api_v1_user_url(user), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post api_v1_users_url,
               params: { api_v1_user: valid_attributes }, headers: {}, as: :json
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new api_v1_user" do
        post api_v1_users_url,
             params: { api_v1_user: valid_attributes }, headers: {}, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post api_v1_users_url,
               params: { api_v1_user: {} }, as: :json
        }.to change(User, :count).by(0)
      end

      it "renders a JSON response with errors for the new api_v1_user" do
        post api_v1_users_url,
             params: { api_v1_user: {} }, headers: {}, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          latitude: "1",
          longitude: "2"
        }
      }

      it "updates the requested api_v1_user" do
        user = create(:user)
        patch api_v1_user_url(user),
              params: { api_v1_user: new_attributes }, headers: {}, as: :json
        user.reload
        expect(user.latitude).to eq("1")
        expect(user.longitude).to eq("2")
      end

      it "renders a JSON response with the api_v1_user" do
        user = create(:user)
        patch api_v1_user_url(user),
              params: { api_v1_user: new_attributes }, headers: {}, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the api_v1_user" do
        user = create(:user)
        patch api_v1_user_url(user),
              params: { api_v1_user: {} }, headers: {}, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
