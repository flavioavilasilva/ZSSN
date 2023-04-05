# frozen_string_literal: true

FactoryBot.define do
  factory :infected_alert do
    user { association :user }
    warned_by_id { create(:user).id }
  end
end
