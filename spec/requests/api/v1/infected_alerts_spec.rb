require 'rails_helper'

RSpec.describe "/api/v1/infected_alerts", type: :request do
  describe "GET /index" do
    it "renders a successful response" do
      user1 = create(:user)
      user2 = create(:user)
      create(:infected_alert, user: user1 , warned_by_id: user2.id)

      get api_v1_user_infected_alerts_url(user1), headers: {}, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user1 = create(:user)
      user2 = create(:user)
      infected_alert = create(:infected_alert, user: user1 , warned_by_id: user2.id)

      get api_v1_user_infected_alerts_url(user1, infected_alert), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new InfectedAlert" do
        user1 = create(:user)
        user2 = create(:user)

        expect {
          post api_v1_user_infected_alerts_url(user1),
               params: { warned_by_id: user2.id }, headers: {}, as: :json
        }.to change(InfectedAlert, :count).by(1)
      end

      it "renders a JSON response with the new api_v1_infected_user" do
        user1 = create(:user)
        user2 = create(:user)

        post api_v1_user_infected_alerts_url(user1),
             params: { warned_by_id: user2.id }, headers: {}, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new InfectedAlert" do
        user1 = create(:user)

        expect {
          post api_v1_user_infected_alerts_url(user1),
               params: {}, as: :json
        }.to change(InfectedAlert, :count).by(0)
      end

      it "renders a JSON response with errors for the new api_v1_infected_user" do
        user1 = create(:user)

        post api_v1_user_infected_alerts_url(user1),
             params: {}, headers: {}, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
