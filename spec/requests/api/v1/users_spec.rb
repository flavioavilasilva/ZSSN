require 'rails_helper'

RSpec.describe "/api/v1/users", type: :request do
 
  let(:valid_attributes) do
    {
      name: "Elvis",
      age: 22,
      gender: "Male",
      latitude: "123",
      longitude: "-1234"
    }
  end

  let(:invalid_attributes) {
    { xpto: "invalid" }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      User.create! valid_attributes
      get api_v1_users_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user = User.create! valid_attributes
      get api_v1_user_url(user), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post api_v1_users_url,
               params: { api_v1_user: valid_attributes }, headers: valid_headers, as: :json
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new api_v1_user" do
        post api_v1_users_url,
             params: { api_v1_user: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post api_v1_users_url,
               params: { api_v1_user: invalid_attributes }, as: :json
        }.to change(User, :count).by(0)
      end

      it "renders a JSON response with errors for the new api_v1_user" do
        post api_v1_users_url,
             params: { api_v1_user: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: "Elvis 2"
        }
      }

      it "updates the requested api_v1_user" do
        user = User.create! valid_attributes
        patch api_v1_user_url(user),
              params: { api_v1_user: new_attributes }, headers: valid_headers, as: :json
        user.reload
        expect(user.name).to eq("Elvis 2")
      end

      it "renders a JSON response with the api_v1_user" do
        user = User.create! valid_attributes
        patch api_v1_user_url(user),
              params: { api_v1_user: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the api_v1_user" do
        user = User.create! valid_attributes
        patch api_v1_user_url(user),
              params: { api_v1_user: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested api_v1_user" do
      user = User.create! valid_attributes
      expect {
        delete api_v1_user_url(user), headers: valid_headers, as: :json
      }.to change(User, :count).by(-1)
    end
  end
end
