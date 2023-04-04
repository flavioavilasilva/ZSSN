require 'rails_helper'

RSpec.describe Validators::GivenItemsPointsValidator do
  it 'is valid' do
    user1 = User.create!(name: "Elvis", age: 22)
    invalid_item = { name: "water", user_id: user1.id }

    expect(Item.new(invalid_item)).to be_valid
  end
  
  context 'with invalids items name' do
    it 'is invalid' do
      user1 = User.create!(name: "Elvis", age: 22)
      invalid_item = { name: "xpto", user_id: user1.id }

      expect(Item.new(invalid_item)).to_not be_valid
    end
  end

  context 'when user is a infected user' do
    it 'is invalid' do
      user1 = User.create!(name: "Elvis", age: 22, infected: true)
      invalid_item = { name: "water", user_id: user1.id }
      
      expect(Item.new(invalid_item)).to_not be_valid
    end
  end
end