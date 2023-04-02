require 'rails_helper'

RSpec.describe Validators::ReceivenItemsPointsValidator do
  it 'is valid' do
    user1 = User.create!(name: "Elvis", age: 22)
    user2 = User.create!(name: "Eli", age: 22)

    given = { user_id: user1.id, items: [ { name: "water", quantity: 1 } ] }
    receiven = { user_id: user2.id, items: [ { name: "food", quantity: 1 }, { name: "ammo", quantity: 1} ] }

    expect(Barter.new(given, receiven)).to be_valid
  end
  
  context 'with diferent points between receiven and given' do
    it 'is invalid' do
      user1 = User.create!(name: "Elvis", age: 22)

      given = { user_id: user1.id, items: [ { name: "water", quantity: 2 } ] }
      receiven = { user_id: user1.id, items: [ { name: "food", quantity: 1 } ] }
      
      expect(Barter.new(given, receiven)).to_not be_valid
    end
  end
end