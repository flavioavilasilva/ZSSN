# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InfectedAlert, type: :model do
  describe '#set_user_infected' do
    context 'when user already has 2 infected alerts' do
      it 'changes user infected status' do
        user1 = create(:user)
        user2 = create(:user)
        create_list(:infected_alert, 2, user: user1)
        params_new_alert = { user: user1, warned_by_id: user2.id }

        expect do
          InfectedAlert.new(params_new_alert).save
        end.to change {
          user1.reload.infected
        }.from(false).to(true)
      end
    end

    context 'when user has less than 2 infected alerts' do
      it 'changes user infected status' do
        user1 = create(:user)
        user2 = create(:user)
        create(:infected_alert, user: user1)
        params_new_alert = { user: user1, warned_by_id: user2.id }

        expect do
          InfectedAlert.new(params_new_alert).save
        end.to_not change {
          user1.reload.infected
        }
      end
    end
  end
end
