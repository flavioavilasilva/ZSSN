require 'rails_helper'

RSpec.describe Reports::LostPointsByInfectedUser, type: :model do
  describe ".points" do
    it "returns 1" do
      user1 = User.create!(name: "Vera", age: 25, infected: false)
      user2 = User.create!(name: "Elvis", age: 25, infected: false)
      user3 = User.create!(name: "Elton", age: 25, infected: false)
      create_list(:item, 2, user: user1)
      create_list(:item, 2, user: user2)
      create_list(:item, 2, user: user3)
      
      user3.update_attribute(:infected, true)

      expect(Reports::LostPointsByInfectedUser.points).to eq(8)
    end
  end
end