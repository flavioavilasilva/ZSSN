class Validators::ReceivenItemsValidator < ActiveModel::Validator
  def validate(record)
    return record.errors.add(:receiven_items, :is_nil) if record.receiven_items.nil?
    return record.errors.add(:receiven_items, :is_empty) if record.receiven_items[:items].nil? || record.receiven_items[:items].empty?
    return record.errors.add(:receiven_items, :is_not_an_array) if record.receiven_items[:items].is_a?(Array) == false
    return record.errors.add(:receiven_items, :empty) if record.receiven_items[:items].empty?
    return record.errors.add(:receiven_items, :equal_users) if record.receiven_items[:user_id] == record.given_items[:user_id] 
  end
end
