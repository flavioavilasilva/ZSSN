# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reports::NotInfectedUser, type: :model do
  describe '.query_count' do
    it 'returns 1' do
      create(:user, infected: false)

      expect(Reports::NotInfectedUser.query_count).to eq(1)
    end
  end
end
