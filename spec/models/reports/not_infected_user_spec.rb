require 'rails_helper'

RSpec.describe Reports::NotInfectedUser, type: :model do
  describe ".query_count" do
    it "returns 1" do
      User.create!(name: "Vera", age: 25, infected: false)

      expect(Reports::NotInfectedUser.query_count).to eq(1)
    end
  end
end