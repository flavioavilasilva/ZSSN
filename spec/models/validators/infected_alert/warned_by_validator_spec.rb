# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Validators::InfectedAlert::WarnedByValidator do
  it 'is valid' do
    user1 = create(:user)
    user2 = create(:user)

    expect(InfectedAlert.new(user: user1, warned_by: user2)).to be_valid
  end

  context 'when warned user is infected' do
    it 'is invalid' do
      user1 = create(:user)
      user2 = create(:user, infected: true)

      expect(InfectedAlert.new(user: user1, warned_by: user2)).to_not be_valid
    end
  end

  context 'when warned user is nil' do
    it 'is invalid' do
      user1 = create(:user)

      expect(InfectedAlert.new(user: user1, warned_by: nil)).to_not be_valid
    end
  end
end
