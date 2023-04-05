class Validators::Barter::GivenItemPointValidator < ActiveModel::Validator
  def validate(record)
    return unless record.given_items_points != record.receiven_items_points

    record.errors.add(:given_items_points,
                      :is_not_enough)
  end
end
