require 'rails_helper'

RSpec.describe "/api/v1/infected_alerts", type: :request do
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
      user1 = User.create!(name: "Elvis", age: 22)
      user2 = User.create!(name: "Arnold", age: 25)
      InfectedAlert.create!(user: user1 , warned_by_id: user2.id)

      get api_v1_user_infected_alerts_url(user1), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user1 = User.create!(name: "Elvis", age: 22)
      user2 = User.create!(name: "Arnold", age: 25)
      infected_alert = InfectedAlert.create!(user: user1 , warned_by_id: user2.id)

      get api_v1_user_infected_alerts_url(user1, infected_alert), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new InfectedAlert" do
        user1 = User.create!(name: "Elvis", age: 22)
        user2 = User.create!(name: "Arnold", age: 25)

        expect {
          post api_v1_user_infected_alerts_url(user1),
               params: { warned_by_id: user2.id }, headers: valid_headers, as: :json
        }.to change(InfectedAlert, :count).by(1)
      end

      it "renders a JSON response with the new api_v1_infected_user" do
        user1 = User.create!(name: "Elvis", age: 22)
        user2 = User.create!(name: "Arnold", age: 25)

        post api_v1_user_infected_alerts_url(user1),
             params: { warned_by_id: user2.id }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new InfectedAlert" do
        user1 = User.create!(name: "Elvis", age: 22)
        user2 = User.create!(name: "Arnold", age: 25)

        expect {
          post api_v1_user_infected_alerts_url(user1),
               params: {}, as: :json
        }.to change(InfectedAlert, :count).by(0)
      end

      it "renders a JSON response with errors for the new api_v1_infected_user" do
        user1 = User.create!(name: "Elvis", age: 22)
        user2 = User.create!(name: "Arnold", age: 25)

        post api_v1_user_infected_alerts_url(user1),
             params: {}, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested api_v1_infected_user" do
      user1 = User.create!(name: "Elvis", age: 22)
      user2 = User.create!(name: "Arnold", age: 25)
      infected_alert = InfectedAlert.create!(user: user1 , warned_by_id: user2.id)

      expect {
        delete api_v1_user_infected_alert_url(user1, infected_alert), headers: valid_headers, as: :json
      }.to change(InfectedAlert, :count).by(-1)
    end
  end
end
