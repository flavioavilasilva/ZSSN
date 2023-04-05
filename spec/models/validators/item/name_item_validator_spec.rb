require 'rails_helper'

RSpec.describe Validators::Item::NameItemValidator do
  it 'is valid' do
    user1 = create(:user)
    invalid_item = { name: "water", user_id: user1.id }

    expect(Item.new(invalid_item)).to be_valid
  end
  
  context 'with invalids items name' do
    it 'is invalid' do
      user1 = create(:user)
      invalid_item = { name: "xpto", user_id: user1.id }

      expect(Item.new(invalid_item)).to_not be_valid
    end
  end

  context 'when user is a infected user' do
    it 'is invalid' do
      user1 = create(:user, infected: true)
      invalid_item = { name: "water", user_id: user1.id }
      
      expect(Item.new(invalid_item)).to_not be_valid
    end
  end
end