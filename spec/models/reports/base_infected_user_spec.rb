require 'rails_helper'

RSpec.describe Reports::BaseInfectedUser, type: :model do
  describe ".percentage" do
    context "when has users" do 
      it "returns the % of infected users" do
        allow(Reports::BaseInfectedUser).to receive(:query_count).and_return(1)
        User.create!(name: "Arnold", age: 25, infected: false)
        User.create!(name: "Vera", age: 25, infected: true)
        
        expect(Reports::BaseInfectedUser.percentage).to eq(50)
      end
    end

    context "when has no users" do 
      it "returns message" do
        expect(Reports::BaseInfectedUser.percentage).to eq("Dados insuficientes")
      end
    end
  end

  describe ".query_count" do
    it "returns 0" do
      expect(Reports::BaseInfectedUser.query_count).to eq(0)
    end
  end
end