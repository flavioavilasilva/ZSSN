require 'rails_helper'

RSpec.describe "/api/v1/items", type: :request do
  
  describe "GET /index" do
    it "renders a successful response" do
      user = User.create!(name: "Elvis", age: 22)
      Item.create!(name: "water", user: user)

      get api_v1_user_items_url(user), headers: {}, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user = User.create!(name: "Elvis", age: 22)
      item = Item.create!(name: "water", user: user)

      get api_v1_user_item_url(user, item), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Item" do
        user = User.create!(name: "Elvis", age: 22)

        expect {
          post api_v1_user_items_url(user),
               params: { name: "water" }, headers: {}, as: :json
        }.to change(Item, :count).by(1)
      end

      it "renders a JSON response with the new api_v1_item" do
        user = User.create!(name: "Elvis", age: 22)

        post api_v1_user_items_url(user),
             params: { name: "water" }, headers: {}, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Item" do
        user = User.create!(name: "Elvis", age: 22)

        expect {
          post api_v1_user_items_url(user),
               params: {}, as: :json
        }.to change(Item, :count).by(0)
      end

      it "renders a JSON response with errors for the new api_v1_item" do
        user = User.create!(name: "Elvis", age: 22)
        post api_v1_user_items_url(user),
             params: {}, headers: {}, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested api_v1_item" do
      user = User.create!(name: "Elvis", age: 22)
      item = Item.create!(name: "Water", user: user)

      expect {
        delete api_v1_user_item_url(user, item), headers: {}, as: :json
      }.to change(Item, :count).by(-1)
    end
  end
end