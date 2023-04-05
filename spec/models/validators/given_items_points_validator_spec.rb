require 'rails_helper'

RSpec.describe Validators::GivenItemsPointsValidator do
  it 'is valid' do
    user1 = create(:user)
    user2 = create(:user)
    given = { user_id: user1.id, items: [ { name: "water", quantity: 1 } ] }
    receiven = { user_id: user2.id, items: [ { name: "food", quantity: 1 }, { name: "ammo", quantity: 1} ] }

    expect(Barter.new(given, receiven)).to be_valid
  end
  
  context 'with diferent points between receiven and given' do
    it 'is invalid' do
      user1 = create(:user)
      given = { user_id: user1.id, items: [ { name: "water", quantity: 2 } ] }
      receiven = { user_id: user1.id, items: [ { name: "food", quantity: 1 } ] }
      
      expect(Barter.new(given, receiven)).to_not be_valid
    end
  end
end