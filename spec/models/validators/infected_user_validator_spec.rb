require 'rails_helper'

RSpec.describe Validators::InfectedUserValidator do
  describe '#validate' do
    it 'is valid' do
      user1 = create(:user, infected: false)
      record = Item.new(name: 'water', user: user1)

      Validators::InfectedUserValidator.new.validate(record)

      expect(record.errors).to be_empty
    end

    it 'is invalid' do
      user1 = create(:user, infected: true)
      record = Item.new(name: 'water', user: user1)

      Validators::InfectedUserValidator.new.validate(record)

      expect(record.errors).to_not be_empty
    end
  end
end
