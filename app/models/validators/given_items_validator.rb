class Validators::GivenItemsValidator < ActiveModel::Validator
  def validate(record)
    return record.errors.add(:given_items, :is_nil) if record.given_items.nil?
    return record.errors.add(:given_items, :is_empty) if record.given_items[:items].nil? || record.given_items[:items].empty?
    return record.errors.add(:given_items, :is_not_an_array) if record.given_items[:items].is_a?(Array) == false
    return record.errors.add(:given_items, :empty) if record.given_items[:items].empty?
    return record.errors.add(:given_items, :equal_users) if record.given_items[:user_id] == record.receiven_items[:user_id]
  end
end
