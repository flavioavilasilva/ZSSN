require 'rails_helper'

RSpec.describe Validators::InfectedUsersValidator do
  describe "#validate" do
    it 'is valid' do
      user1 = User.create!(name: "Elvis", age: 22, infected: false)
      record = Item.new(name: "water", user: user1)

      Validators::InfectedUsersValidator.new.validate(record)

      expect(record.errors).to be_empty
    end

    it "is invalid" do
      user1 = User.create!(name: "Elvis", age: 22, infected: true)
      record = Item.new(name: "water", user: user1)

      Validators::InfectedUsersValidator.new.validate(record)

      expect(record.errors).to_not be_empty
    end
  end
end