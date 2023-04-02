require 'rails_helper'

RSpec.describe BarterService, type: :service do
  context "When barter is valid" do
    it "transfers the items between the users" do
      user1 = User.create!(name: "Elvis", age: 22)
      Item.create!(name: "water", user: user1)
      Item.create!(name: "water", user: user1)
      Item.create!(name: "food", user: user1)
  
      user2 = User.create!(name: "Arnold", age: 25)
      Item.create!(name: "food", user: user2)
      Item.create!(name: "ammo", user: user2)
  
      givin = { user_id: user1.id, items: [ { name: "water", quantity: 1 } ] }
      receiven = { user_id: user2.id, items: [ { name: "food", quantity: 1 }, { name: "ammo", quantity: 1} ] }
      barter = Barter.new(givin, receiven)
      
      BarterService.new(barter).call
      
      expect(user1.items.reload.size).to eq 4
      expect(user1.items.map(&:name)).to include("food")
      expect(user1.items.map(&:name)).to include("ammo")
  
      expect(user2.items.reload.size).to eq 1
      expect(user2.items.map(&:name)).to include("water")
    end
  end

  context "When barter is NOT valid" do
    it "not change user items and barter object return errors" do
      barter = Barter.new({}, {})

      barter_service = BarterService.new(barter)

      expect(barter_service.call).to be(false)
      expect(barter.errors).to_not be_empty
    end
  end

  context "When has some error in transaction" do
    before do 
      allow_any_instance_of(ActiveRecord::Relation).to receive(:update_all).and_raise(ActiveRecord::StatementInvalid)
    end

    it "the users items not change" do 
      user1 = User.create!(name: "Elvis", age: 22)
      Item.create!(name: "water", user: user1)
      Item.create!(name: "food", user: user1)
  
      user2 = User.create!(name: "Arnold", age: 25)
      Item.create!(name: "food", user: user2)
      Item.create!(name: "ammo", user: user2)
  
      givin = { user_id: user1.id, items: [ { name: "water", quantity: 1 } ] }
      receiven = { user_id: user2.id, items: [ { name: "food", quantity: 1 }, { name: "ammo", quantity: 1} ] }
      barter = Barter.new(givin, receiven)

      barter_service = BarterService.new(barter).call
      
      expect { 
        barter_service 
      }.to_not change { 
                  user1.items.reload.size
                  user2.items.reload.size
               }
      expect(barter_service).to be(false)
      expect(barter.errors).to_not be_empty
    end
  end

  

  # context "when some user has no items to change" do
  #   it "not change user items and barter object return errors" do 
  #     user1 = User.create!(name: "Elvis", age: 22)
  #     Item.create!(name: "water", user: user1)

  #     user2 = User.create!(name: "Arnold", age: 25)

  #     givin = { user_id: user1.id, items: [ { name: "water", quantity: 1 } ] }
  #     receiven = { user_id: user2.id, items: [] }
  #     barter = Barter.new(givin, receiven)
      
  #     barter_service = BarterService.new(barter)

  #     expect { barter_service.call }.to_not change { user1.items.size }
  #     expect(barter.errors).to_not be_empty
  #   end
  # end

  # context "when users are not diferents" do
  #   it "not change user items and barter object return errors" do 
  #     user1 = User.create!(name: "Elvis", age: 22)
  #     Item.create!(name: "water", user: user1)

  #     givin = { user_id: user1.id, items: [ { name: "water", quantity: 1 } ] }
  #     receiven = { user_id: user1.id, items: [ { name: "water", quantity: 1 } ] }
  #     barter = Barter.new(givin, receiven)
      
  #     barter_service = BarterService.new(barter)

  #     expect { barter_service.call }.to_not change { user1.items.size }
  #     expect(barter.errors).to_not be_empty
  #   end
  # end

  # context "when the items no have the same points" do

  # end

  # context "when some user has been infected" do

  # end
end