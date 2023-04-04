require 'rails_helper'

RSpec.describe Reports::InfectedUser, type: :model do
  describe ".query_count" do
    it "returns 1" do
      User.create!(name: "Vera", age: 25, infected: true)

      expect(Reports::InfectedUser.query_count).to eq(1)
    end
  end
end