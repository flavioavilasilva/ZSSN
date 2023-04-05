# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { 'water' }
    user { association :user }
  end
end
