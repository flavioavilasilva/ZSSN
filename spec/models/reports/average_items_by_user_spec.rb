require 'rails_helper'

RSpec.describe Reports::AverageOfItemsByUser, type: :model do
  describe '.items' do
    it 'returns 1' do
      user1 = User.create!(name: 'Vera', age: 25, infected: false)
      user2 = User.create!(name: 'Elvis', age: 25, infected: false)
      user3 = User.create!(name: 'Elvis', age: 25, infected: false)
      create_list(:item, 2, user: user1)
      create_list(:item, 2, user: user2)
      create_list(:item, 2, user: user3)

      user3.update_attribute(:infected, true)

      expected_items = [
        { water: 2 },
        { food: 0 },
        { medicine: 0 },
        { ammo: 0 }
      ]

      expect(Reports::AverageOfItemsByUser.items).to match_array(expected_items)
    end
  end
end
