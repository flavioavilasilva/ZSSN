# frozen_string_literal: true

class Validators::Barter::ReceivenItemPointValidator < ActiveModel::Validator
  def validate(record)
    return unless record.receiven_items_points != record.given_items_points

    record.errors.add(:receiven_items_points,
                      :is_not_enough)
  end
end
