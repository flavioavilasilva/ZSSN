require 'rails_helper'

RSpec.describe Barter, type: :model do
  describe '#given_items_points' do
    it 'return sum of the given items points' do
      user1 = create(:user)
      user2 = create(:user)
      given = { items: [{ name: 'water', quantity: 2 }] }

      expect(Barter.new(given, {}).given_items_points).to eq(8)
    end
  end

  describe '#receiven_items_points' do
    it 'return sum of the receiven items points' do
      user1 = create(:user)
      user2 = create(:user)
      receiven = { items: [{ name: 'water', quantity: 1 }] }

      expect(Barter.new({}, receiven).receiven_items_points).to eq(4)
    end
  end
end
