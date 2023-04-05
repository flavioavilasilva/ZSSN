require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#set_points' do
    it 'after initialize sets the item points' do
      expect(Item.new(name: 'water', user_id: 1).points).to eq(4)
    end

    context 'when name is nil on initialize' do
      it 'does not raise error and returns nil' do
        expect(Item.new(name: nil, user_id: 1).points).to eq(nil)
      end
    end
  end
end
