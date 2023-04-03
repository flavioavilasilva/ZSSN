require 'rails_helper'

RSpec.describe InfectedAlert, type: :model do
  describe "#set_user_infected" do
    context "when user already has 2 infected alerts" do
      it "changes user infected status" do
        user1 = User.create!(name: "Elvis", age: 22)
        user2 = User.create!(name: "Arnold", age: 25)
        user3 = User.create!(name: "Vera", age: 25)

        InfectedAlert.create!(user: user1 , warned_by_id: user1.id)
        InfectedAlert.create!(user: user1 , warned_by_id: user2.id)
        params_new_alert = { user: user1, warned_by_id: user3.id }
        
        expect {
          InfectedAlert.new(params_new_alert).save
        }.to change { 
          user1.reload.infected 
        }.from(false).to(true)
      end
    end

    context "when user has less than 2 infected alerts" do
      it "changes user infected status" do
        user1 = User.create!(name: "Elvis", age: 22)
        user2 = User.create!(name: "Arnold", age: 25)

        InfectedAlert.create!(user: user1 , warned_by_id: user1.id)
        params_new_alert = { user: user1, warned_by_id: user2.id }
        
        expect {
          InfectedAlert.new(params_new_alert).save
        }.to_not change { 
          user1.reload.infected 
        }
      end
    end
  end
end
