require 'rails_helper'

RSpec.describe Validators::ReceivenItemsValidator do
  it 'is valid' do
    user1 = create(:user)
    user2 = create(:user)
    given = { user_id: user1.id, items: [ { name: "water", quantity: 1 } ] }
    receiven = { user_id: user2.id, items: [ { name: "food", quantity: 1 }, { name: "ammo", quantity: 1} ] }

    expect(Barter.new(given, receiven)).to be_valid
  end
  
  context 'with the same user of the given_items' do
    it 'is invalid' do
      user1 = create(:user)
      given = { user_id: user1.id, items: [ { name: "water", quantity: 1 } ] }
      receiven = { user_id: user1.id, items: [ { name: "food", quantity: 1 }, { name: "ammo", quantity: 1} ] }
      
      expect(Barter.new(given, receiven)).to_not be_valid
    end
  end

  context 'with empty receiven_items' do
    it 'is invalid' do
      user1 = create(:user)
      user2 = create(:user)
      given = { user_id: user1.id, items: [ { name: "water", quantity: 1 } ] }
      receiven = { user_id: user2.id, items: [] }
      
      expect(Barter.new(given, receiven)).to_not be_valid
    end
  end

  context 'with infected user' do
    it 'is invalid' do
      user1 = create(:user, infected: false)
      user2 = create(:user, infected: true)
      given = { user_id: user1.id, items: [ { name: "water", quantity: 1 } ] }
      receiven = { user_id: user2.id, items: [ { name: "water", quantity: 1 } ] }
      
      expect(Barter.new(given, receiven)).to_not be_valid
    end
  end
end