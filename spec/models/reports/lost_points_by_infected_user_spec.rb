require 'rails_helper'

RSpec.describe Reports::LostPointsByInfectedUser, type: :model do
  describe ".points" do
    it "returns 1" do
      user1 = User.create!(name: "Vera", age: 25, infected: false)
      user2 = User.create!(name: "Elvis", age: 25, infected: false)
      user3 = User.create!(name: "Elvis", age: 25, infected: false)

      Item.create!(name: "water", user: user1, points: 4)
      Item.create!(name: "water", user: user1, points: 4)

      Item.create!(name: "water", user: user2, points: 4)
      Item.create!(name: "water", user: user2, points: 4)

      Item.create!(name: "water", user: user3, points: 4)
      Item.create!(name: "water", user: user3, points: 4)

      user3.update_attribute(:infected, true)

      expect(Reports::LostPointsByInfectedUser.points).to eq(8)
    end
  end
end