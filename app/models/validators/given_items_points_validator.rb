class Validators::GivenItemsPointsValidator < ActiveModel::Validator
  def validate(record)
    return record.errors.add(:given_items_points, :is_not_enough) if record.given_items_points != record.receiven_items_points
  end
end
