class Validators::Barter::ReceivenItemPointValidator < ActiveModel::Validator
  def validate(record)
    return record.errors.add(:receiven_items_points, :is_not_enough) if record.receiven_items_points != record.given_items_points
  end
end
