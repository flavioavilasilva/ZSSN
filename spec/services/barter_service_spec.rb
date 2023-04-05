require 'rails_helper'

RSpec.describe BarterService, type: :service do
  context 'When barter is valid' do
    it 'transfers the items between the users' do
      user1 = create(:user)
      create_list(:item, 2, user: user1, name: 'water')
      create(:item, user: user1, name: 'food')

      user2 = create(:user)
      create(:item, user: user2, name: 'food')
      create(:item, user: user2, name: 'ammo')

      givin = { user_id: user1.id, items: [{ name: 'water', quantity: 1 }] }
      receiven = { user_id: user2.id, items: [{ name: 'food', quantity: 1 }, { name: 'ammo', quantity: 1 }] }
      barter = Barter.new(givin, receiven)

      BarterService.new(barter).call

      expect(user1.items.reload.size).to eq 4
      expect(user1.items.map(&:name)).to include('food')
      expect(user1.items.map(&:name)).to include('ammo')

      expect(user2.items.reload.size).to eq 1
      expect(user2.items.map(&:name)).to include('water')
    end
  end

  context 'When barter is NOT valid' do
    it 'not change user items and barter object return errors' do
      barter = Barter.new({}, {})

      barter_service = BarterService.new(barter)

      expect(barter_service.call).to be(false)
      expect(barter.errors).to_not be_empty
    end
  end

  context 'When has some error in transaction' do
    before do
      allow_any_instance_of(ActiveRecord::Relation).to receive(:update_all).and_raise(ActiveRecord::StatementInvalid)
    end

    it 'the users items not change' do
      user1 = create(:user)
      create(:item, user: user1, name: 'water')
      create(:item, user: user1, name: 'food')

      user2 = User.create!(name: 'Arnold', age: 25)
      create(:item, user: user2, name: 'food')
      create(:item, user: user2, name: 'ammo')

      givin = { user_id: user1.id, items: [{ name: 'water', quantity: 1 }] }
      receiven = { user_id: user2.id, items: [{ name: 'food', quantity: 1 }, { name: 'ammo', quantity: 1 }] }
      barter = Barter.new(givin, receiven)

      barter_service = BarterService.new(barter).call

      expect do
        barter_service
      end.to_not change {
                   user1.items.reload.size
                   user2.items.reload.size
                 }
      expect(barter_service).to be(false)
      expect(barter.errors).to_not be_empty
    end
  end
end
