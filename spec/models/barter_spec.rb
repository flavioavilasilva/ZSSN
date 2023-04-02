require 'rails_helper'

RSpec.describe Barter, type: :model do
  describe "#given_items_points" do
    it "return sum of the given items points" do
      user1 = User.create!(name: "Elvis", age: 22)
      user2 = User.create!(name: "Eli", age: 22)

      given = { items: [ { name: "water", quantity: 2 } ] }

      expect(Barter.new(given, {}).given_items_points).to eq(8)
    end
  end

  describe "#receiven_items_points" do
    it "return sum of the receiven items points" do
      user1 = User.create!(name: "Elvis", age: 22)
      user2 = User.create!(name: "Eli", age: 22)

      receiven = { items: [ { name: "water", quantity: 1 } ] }

      expect(Barter.new({}, receiven).receiven_items_points).to eq(4)
    end
  end
end